function DEM_demo_duet
% This demonstration uses active inference (as implemented in spm_ALAP) to
% illustrate birdsong and communication using predictive coding. In this
% example, priors on high-level sensorimotor constructs (e.g., in the
% avian higher vocal centre) are used to generate proprioceptive
% predictions (i.e., motor commands) so that the bird can sing. However, in
% the absence of sensory attenuation, the slight differences between
% descending predictions and the sensory consequences of self-made songs
% confound  singing. This means that sensory attenuation is required so
% that the bird can either sing or listen.  By introducing a second bird
% and alternating between singing and listening respectively, one can
% simulate communication through birdsong. This is illustrated with one
% cycle of singing and listening, where the high level expectations about
% hidden states become synchronised; in effect, the two birds are singing
% from the same 'hymn sheet' or narrative and can be regarded as
% communicating in the sense of pragmatics. The first bird's expectations
% are shown in red, while the second bird's are shown in cyan.
%
% To simulate learning of each other's (high-level) attractor, set LEARN to
% one in the  main script.. To separate the birds � and preclude
% communication (or synchronisation chaos) set NULL to 1.
%__________________________________________________________________________
% Copyright (C) 2008 Wellcome Trust Centre for Neuroimaging
 
% Karl Friston
% $Id: DEM_demo_duet.m 6235 2014-10-12 10:03:05Z karl $
 

% preliminaries
%--------------------------------------------------------------------------
rng('default')

LEARN = 0;                                 % enables learning
NULL  = 0;                                 % no communication

A   = 2;                                   % number of agents (birds)
T   = 2;                                   % number of trials
dt  = 1/64;                                % time bin (seconds)
N   = 128;                                 % length of stimulus (bins)
w   = 2;                                   % precision of flow

if LEARN, N = 128; A = 2; T = 16; end      % learning enabled


% generative process and model
%==========================================================================
M(1).E.d        = 1;                       % approximation order
M(1).E.n        = 3;                       % embedding order
M(1).E.s        = 1/2;                     % smoothness
 
M(1).E.method.x = 0;                       % state-dependent noise
M(1).E.method.v = 0;                       % state-dependent noise
M(1).E.method.h = 0;                       % suppress optimisation
M(1).E.method.g = 0;                       % suppress optimisation

% initialise parameters, states and precisions
%--------------------------------------------------------------------------
P     = cell(A,1);
x     = cell(A,1);
a     = cell(A,1);
U     = cell(1,A);
V     = cell(1,A);

x0    = [1; 1];

Up    = exp([ 8  8 -8 -8]);                % sensory attenutation
Uq    = exp([-8 -8 -8 -8]);                % sensory attention
Vp    = exp([-8 -8 -w -w]);                % attenutation
Vq    = exp([-8 -8  w  w]);                % attention

for i = 1:A
    if rem(i,2), U{i} = Up; else, U{i} = Uq; end
    if rem(i,2), V{i} = Vp; else, V{i} = Vq; end
end


% level 1 of generative process: tto hidden states (amplitude and
% frequency of a bird's syrinx) generate proprioceptive and auditory
% sensations. These hidden states are driven by (2-D) action.
%--------------------------------------------------------------------------
for i = 1:A
    x{i} = x0;                             % states (of syrinx)
end
G(1).f  = @(x,v,a,P) a - spm_vec(x)/4;
if NULL
    G(1).g  = @(x,v,a,P) Gg0(x,v,a,P);     % SOUND PRODUCTION - distant
else
    G(1).g  = @(x,v,a,P) Gg1(x,v,a,P);     % SOUND PRODUCTION - close
end
G(1).x  = x;                               % hidden state
G(1).V  = exp(8);                          % precision (noise)
G(1).W  = exp(8);                          % precision (states)
G(1).U  = spm_cat(U);                      % precision (action)

 
% level 2; causes
%--------------------------------------------------------------------------
for i = 1:A
    a{i} = [0; 0];                         % action (fequency and volume)
end
G(2).v  = 0;                               % exogenous  cause
G(2).a  = spm_vec(a);                      % endogenous cause (action)
G(2).V  = exp(8);



% level 1 of the generative model: proprioceptive and auditory signals are 
% generated by three hidden states with attractor dynamics. The Raleigh
% number (control parameters) of these dynamics constitute the hidden cause
%--------------------------------------------------------------------------
for i = 1:A
    x{i} = [1; x0];                        % hidden states
end
M(1).f  = @(x,v,P) Mf1(x,v,P);
M(1).g  = @(x,v,P) Mg1(x,v,P);
M(1).x  = x;
M(1).pE = {6,6};
M(1).W  = exp(w);
M(1).V  = spm_cat(V); 

% level 2: the hidden cause is the third state of another (slower) Lorentz
% attractor, with fixed control parameters.
%--------------------------------------------------------------------------
for i = 1:A
    x{i} = [1; 1; 30];                     % hidden states
    if i > 1
        x{i} = [1; 1; 1];                  % hidden states
    end
end
M(2).f  = @(x,v,P) Mf2(x,v,P);
M(2).g  = @(x,v,P) Mg2(x,v,P);
M(2).x  = x;
M(2).v  = 0;
M(2).W  = exp(8);
M(2).V  = exp(8);

% hidden cause and prior expectations
%--------------------------------------------------------------------------
if LEARN
    M(1).pE = {6,0};
    M(1).pC = [1/16 4];
end

 
% hidden cause and prior expectations
%--------------------------------------------------------------------------
C     = zeros(1,N);

% assemble model structure
%--------------------------------------------------------------------------
M(1).E.nE = 1;

DEM.M = M;
DEM.G = G;
DEM.C = C;

% reset initial hidden states and invert
%==========================================================================
p = zeros(3,T);
c = zeros(3,T);
for t = 1:T
    
    DEM    = spm_ADEM(DEM);
    LAP{t} = DEM;
    
    
    % update percicions & switch roles (sensory attenuation vs. attention)
    %----------------------------------------------------------------------
    if rem(t,2)
        for i = 1:A
            if rem(i,2), U{i} = Uq; else, U{i} = Up; end
            if rem(i,2), V{i} = Vq; else, V{i} = Vp; end
        end
    else
        for i = 1:A
            if rem(i,2), U{i} = Up; else, U{i} = Uq; end
            if rem(i,2), V{i} = Vp; else, V{i} = Vq; end
        end
    end
    DEM.G(1).U  = spm_cat(U);
    DEM.M(1).V  = spm_cat(V);
    

    % synchronisation manifold
    %======================================================================
    if LEARN
        
        
        spm_figure('GetWin','Figure 3');
        if t == 2
            subplot(2,2,3)
        else
            subplot(2,2,4)
        end
        
        x = LAP{t}.qU.x{2}([1 2 3],:);
        y = LAP{t}.qU.x{2}([1 2 3] + 3,:);
 
        plot(x',y')
        title('Synchronization manifold','Fontsize',16)
        xlabel('second level expectations (first bird)')
        ylabel('second level expectations (second bird)')
        axis square
        
        p(1:2,t) = spm_vec(DEM.M(1).pE);
        c(1:2,t) = spm_vec(diag(DEM.M(1).pC));
        
        subplot(2,1,1)
        spm_plot_ci(p,c)
        title('Parameter learning','Fontsize',16)
        xlabel('control parameter (first bird)')
        ylabel('trials')
        spm_axis tight
        drawnow
        
    else
        spm_DEM_qU(LAP{t}.qU,LAP{t}.pU)
    end
    
    % update states and action
    %----------------------------------------------------------------------
    DEM = spm_ADEM_update(DEM,1/32);

end


% illustrate responses with sonogram (and sound file)
%==========================================================================
spm_figure('GetWin','Figure 1'); clf


% sonogram (reducing the second birds percepts by a half)
%--------------------------------------------------------------------------
T     = 2;
qU    = [];
for t = 1:T
    v      = LAP{t}.qU.v{1}([1 2],:);
    v(1,:) = v(1,:)/max(abs(v(1,:)));
    if rem(t - 1,2)
        v(1,:) = v(1,:)/2;
    end
    qU = [qU v];
end

% synchronisation of expectations about hidden states at the first level
%--------------------------------------------------------------------------
subplot(3,1,1)
colormap('pink')
spm_DEM_play_song(qU,T*N*dt);
title('percept','Fontsize',16)

subplot(3,1,2)
for i = 1:A
    x = [];
    for t = 1:T
        x = [x LAP{t}.qU.x{1}([1 2 3] + (i - 1)*3,:)];
    end
    if i > 1
        plot((1:size(x,2))*dt,x,'c'),hold on
    else
        plot((1:size(x,2))*dt,x,'r'),hold on
    end
end
xlabel('time (seconds)')
title('First level expectations (hidden states)','Fontsize',16)

% synchronisation of expectations about hidden states at the second level
%--------------------------------------------------------------------------
subplot(3,1,3)
for i = 1:A
    x = [];
    for t = 1:T
        x = [x LAP{t}.qU.x{2}([1 2 3] + (i - 1)*3,:)];
    end
    if i > 1
        plot((1:size(x,2))*dt,x,'c'),hold on
    else
        plot((1:size(x,2))*dt,x,'r'),hold on
    end
end
xlabel('time (seconds)')
title('Second level expectations (hidden states)','Fontsize',16)

% synchronisation manifold
%==========================================================================
spm_figure('GetWin','Figure 2'); clf
subplot(2,1,1)

x = [];
y = [];
for t = 1:T
    x = [x LAP{t}.qU.x{2}([1 2 3],:)];
    y = [y LAP{t}.qU.x{2}([1 2 3] + 3,:)];
end

plot(x',y')
title('Synchronization manifold','Fontsize',16)
xlabel('second level expectations (first bird)')
ylabel('second level expectations (second bird)')
axis square



% Equations of motion and observer functions
%==========================================================================

% first level process: mapping hidden causes to sensations (when the
% birds cannot hear each other)
%--------------------------------------------------------------------------
function g = Gg0(x,v,a,P)
for i = 1:length(x)
    g{i,1} = [x{i}; x{i}];
end

% first level process: mapping hidden causes to sensations (when the 
% birds only hear the loudest frequency)
%--------------------------------------------------------------------------
function g = Gg1(x,v,a,P)
for i = 1:length(x)
    s(i)   = abs(x{i}(1));
end
[a j] = max(s);
for i = 1:length(x)
    g{i,1} = [x{i}; x{j}];
end

% first level model: mapping hidden causes to sensations
%--------------------------------------------------------------------------
function g = Mg1(x,v,P)
for i = 1:length(x)
    g{i,1} = x{i}([2 3 2 3]);
end

% second level model: mapping hidden causes to hidden states
%--------------------------------------------------------------------------
function g = Mg2(x,v,P)
for i = 1:length(x)
    g{i,1} = x{i}(3);
end

% first level model: flow of hidden states
%--------------------------------------------------------------------------
function f = Mf1(x,v,P)
for i = 1:length(x)
    p      = spm_softmax([0; P{i}]);
    dxdt   = [-10 10 0; (v{i}(1) - [8 4]*p - x{i}(3)) -1 0; x{i}(2) 0 -8/3]*x{i}/16;
    f{i,1} = min(max(dxdt,-32),32);
end


% second level model: flow of hidden states
%--------------------------------------------------------------------------
function f = Mf2(x,v,P)
for i = 1:length(x)

    dxdt   = [-10 10 0; (32 - x{i}(3)) -1 0; x{i}(2) 0 -8/3]*x{i}/128;
    f{i,1} = min(max(dxdt,-4),4);
end



 