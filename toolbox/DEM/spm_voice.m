function spm_voice(PATH)
% Creates lexical and prosody cell arrays from sound file exemplars
% FORMAT spm_voice(PATH)
%
% PATH         -  directory containing sound files of exemplar words
%
% saves VOX.mat
%
% VOX.LEX(w,k) -  structure array for k variants of w words
% VOX.PRO(p)   -  structure array for p aspects of prosody
% VOX.WHO(w)   -  structure array for w aspects of idenity
%
%  This routine creates structure arrays used to infer the lexical and
%  prosody of a word. It uses a library of sound files, each containing 32
%  words spoken with varying prosody. The name of the sound file labels the
%  word in question. These exemplars are then transformed (using a series
%  of discrete cosine and Hilbert transforms) into a set of parameters,
%  which summarise the lexical content and prosody. The inverse transform
%  generates  timeseries that can be played to articulate a word. The
%  transform operates on a word structure xY to create lexical and prosody
%  parameters (Q and P respectively). The accuracy of  lexical inference
%  (i.e., voice the word recognition) is assessed  using the exemplar
%  (training) set and a narrative sound file called '../test.wav' (and
%  associated '../test.txt'). The operation of each subroutine can be
%  examined using graphical outputs by selecting the appropriate options in
%  a voice recognition specific global variable.
%__________________________________________________________________________
% Copyright (C) 2008 Wellcome Trust Centre for Neuroimaging

% Karl Friston
% $Id: spm_voice.m 7566 2019-04-03 12:15:50Z karl $



%% setup options and files
%==========================================================================

% directory of sound files if necessary
%--------------------------------------------------------------------------
clear global VOX
if ~nargin
    PATH = 'C:\Users\karl\Dropbox\Papers\Voice recognition\Sound files';
end

global VOX
VOX.graphics = 0;
VOX.mute     = 1;
VOX.onsets   = 1;


%% get corpus
%==========================================================================
[xY,word] = spm_voice_get_xY(PATH);

%% get VOX (LEX, PRO and WHO) and parameters; e.g., 1/F0  = mean(P(:,6));
%==========================================================================
P     = spm_voice_get_LEX(xY,word);


%% articulate every word under all combinations of (5 levels) of prosody
%--------------------------------------------------------------------------
VOX.mute = 0;
nw    = numel(VOX.LEX);                       % number of words
k     = [3 6];                                % number of prosody features
for w = 1:nw
    for i = k
        for j = k
            spm_voice_speak(w,[8;5;5;5;i;j;4],4);
            pause(1/4)
        end
    end
end


%%  apply to test narrative of 87 words (this will search over the bases)
%--------------------------------------------------------------------------
spm_voice_test('../test.wav','../test.txt');


%% save lexical and prosody arrays in sound file directory
%--------------------------------------------------------------------------
save VOX VOX


%% read the first few words of a test file
%--------------------------------------------------------------------------
spm_voice_read('../test.wav');



%% record and repeat some dictation
%--------------------------------------------------------------------------
spm_voice_read


%% illustrate word by word recognition
%==========================================================================

% prior words
%--------------------------------------------------------------------------
clear str
str{1} = {'is'};
str{2} = {'there'};
str{3} = {'a'};
str{4} = {'triangle','square'};
str{5} = {'below','above','there'};

P     = zeros(numel(VOX.LEX),0);
for w = 1:numel(str)
    i      = spm_voice_i(str{w});
    P(i,w) = 1;
end
P     = bsxfun(@rdivide,P,sum(P));

% get priors
%--------------------------------------------------------------------------
wfile     = audiorecorder(22050,16,1);
VOX.audio = wfile;


%% record
%==========================================================================
stop(wfile);
record(wfile,4);

%% run through sound file and evaluate likelihoods
%==========================================================================
clear W Q R SEG
VOX.I0 = 1;                                    % first index
VOX.IT = 1;                                    % final index
for s  = 1:numel(str)
    
    % find next word
    %----------------------------------------------------------------------
    L   = spm_voice_get_word(wfile,P(:,s));
        
    % break if EOF
    %----------------------------------------------------------------------
    if isempty(L), break, end
    
    % identify the most likely word and prosody
    %----------------------------------------------------------------------
    [d,w]  = max(L{1});                        % most likely word
    [d,q]  = max(L{2});                        % most likely prosody
    [d,r]  = max(L{3});                        % most likely identity
    W(1,s) = w(:);                             % lexical class
    Q(:,s) = q(:);                             % prosody classes
    R(:,s) = r(:);                             % speaker classes
    
    % string
    %----------------------------------------------------------------------
    SEG(s).str = VOX.LEX(w,1).word;            % lexical string
    SEG(s).I0  = VOX.I0;                       % centre
    SEG(s).IT  = VOX.IT;                       % range
    SEG(s).P   = Q(:,s);                       % prosody
    SEG(s).R   = R(:,s);                       % speaker
    
    disp({SEG.str})
    
end

% articulate: with lexical content and prosody
%--------------------------------------------------------------------------
spm_voice_speak(W,Q,R);

%% segmentation graphics
%--------------------------------------------------------------------------
spm_voice_segmentation(wfile,SEG)



%%  illustrate voice recognition (i.e., inference) based upon eigenmodes
%==========================================================================

% likelihood of training set
%--------------------------------------------------------------------------
[nw,ns] = size(xY);
    
q     = [];
p     = [];
r     = 0;
J     = 0;
for i = 1:nw
    for j = 1:ns
        
        % evaluate lexical (L) and prosody (M) likelihoods
        %------------------------------------------------------------------
        [L,M] = spm_voice_likelihood(xY(i,j));
        L(:)  = spm_softmax(L(:));
        M     = spm_softmax(M);
        L     = sum(L,2);
        
        % inferred and true lexical outcome
        %------------------------------------------------------------------
        q(:,end + 1) = L;
        p(i,end + 1) = 1;
        r        = r + M;
    end
end

% show results
%--------------------------------------------------------------------------
spm_figure('GetWin','Accuracy'); clf
subplot(2,1,1); imagesc(q)
a     = 1 - sum((p(:) - q(:)) > 1/8)/sum(p(:));
str   = sprintf('Lexical classification accuracy %-2.0f p.c.',100*a);
title(str,'FontSize',16), xlabel('exemplars'), ylabel('words')
set(gca,'Ytick',1:nw),set(gca,'YtickLabel',{VOX.LEX.word})

subplot(3,1,3); imagesc(r'), axis image
j     = numel(VOX.PRO);
k     = numel(VOX.PRO(1).pE);
xlabel('level'), ylabel('attribute'), title('Prosody','FontSize',16)
set(gca,'Xtick',1:k),set(gca,'Ytick',1:j),set(gca,'YtickLabel',{VOX.PRO.str})

return


%% auxiliary code
%==========================================================================

%% optmise spectral defaultswith respect to classification accuracy
%==========================================================================
clear all
global VOX
PATH = 'C:\Users\karl\Dropbox\Papers\Voice recognition\Sound files';

% reporting options
%--------------------------------------------------------------------------
VOX.graphics = 0;
VOX.mute     = 1;
VOX.onsets   = 0;

% expansion point (i.e., defaults)
%--------------------------------------------------------------------------
VOX.Nu  = 32;
VOX.Nv  = 8;
VOX.Tu  = 4;
VOX.Tv  = 1;
VOX.E   = 64;
VOX.F0  = 96;
VOX.F1  = 32;
VOX.F2  = 1024;

% search over variables
%--------------------------------------------------------------------------
Pu    = 16:4:64;
Pv    = 82:4:128;
for i = 1:numel(Pu)
    for j = 1:numel(Pv);
        try
            VOX = rmfield(VOX,'nu');
            VOX = rmfield(VOX,'nv');
        end
            
        VOX.F1 = Pu(i);
        VOX.F0 = Pv(j);
        
        [xY,word] = spm_voice_get_xY(PATH);
        P         = spm_voice_get_LEX(xY,word);
        A(i,j)    = spm_voice_test('../test.wav','../test.txt')
    end
end

imagesc(Pv,Pu,A), axis square, title('Accuracy','FontSize',16),drawnow


%% auxiliary code
%==========================================================================

% load script and prompt for audio file: 32 words, at one word per second
%--------------------------------------------------------------------------
tfile = '../test.txt';
str   = textread(tfile,'%s');
str   = unique(str);
for s = 1:numel(str)
    clc,  disp([str(s) 'new file']), pause
    for i = 1:32
        clc,disp(str(s));     pause(0.9)
        clc,disp('    -*- '); pause(0.1)
    end
end

