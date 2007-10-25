function [sig,a] = spm_dartel_smooth(t,lam,its,vx,a)
% A function for smoothing tissue probability maps
% FORMAT [sig,a_new] = spm_dartel_smooth(t,lam,its,vx,a_old)
%________________________________________________________
% (c) Wellcome Centre for NeuroImaging (2007)

% John Ashburner
% $Id: spm_dartel_smooth.m 980 2007-10-25 16:08:54Z john $

if nargin<5, a   = zeros(size(t),'single'); end
if nargin<4, vx  = [1 1 1]; end;
if nargin<3, its = 16;      end;
if nargin<2, lam = 1;       end;

d   = size(t);
W   = zeros([d(1:3) round((d(4)*(d(4)+1))/2)],'single');
s   = max(sum(t,4),single(0));
for k=1:d(4),
    t(:,:,:,k) = t(:,:,:,k)./abs(s+eps);
end
for i=1:its,
    %trnc=log(realmax('single'));
    %a   = max(min(a,trnc),-trnc);
    sig = softmax(a);
    gr  = sig - t;
    for k=1:d(4),
        gr(:,:,:,k) = gr(:,:,:,k).*s;
    end
    gr  = gr + optimN('vel2mom',a,[2 vx lam 0 0]);
    jj  = d(4)+1;
    reg = 2*sqrt(eps('single'))*d(4)^2;
    for j1=1:d(4),
        W(:,:,:,j1) = (sig(:,:,:,j1).*(1-sig(:,:,:,j1)) + reg).*s;
        for j2=1:j1-1,
            W(:,:,:,jj) = -sig(:,:,:,j1).*sig(:,:,:,j2).*s;
            jj = jj+1;
        end
    end
    a   = a - optimN(W,gr,[2 vx lam 0 lam*1e-3 1 1]);
    %a  = a - mean(a(:)); % unstable
    a   = a - sum(sum(sum(sum(a))))/numel(a);
    fprintf(' %g,', sum(gr(:).^2)/numel(gr));
    drawnow 
end;
fprintf('\n');
sig = softmax(a);
return;

function sig = softmax(a)
sig = zeros(size(a),'single');
for j=1:size(a,3),
    aj = double(squeeze(a(:,:,j,:)));
    trunc = log(realmax*(1-eps));
    aj = min(max(aj-mean(aj(:)),-trunc),trunc);
    sj = exp(aj);
    s  = sum(sj,3);
    for i=1:size(a,4),
        sig(:,:,j,i) = single(sj(:,:,i)./s);
    end
end;

