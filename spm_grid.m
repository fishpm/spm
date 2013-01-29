function I = spm_grid(I)
% Superimpose a Talairach and Tournoux grid
% FORMAT O = spm_grid(I)
% I - image matrix
% O - image matrix with grid added
%__________________________________________________________________________
%
% spm_grid adds a grid to the input argument.
% The grid is scaled to 10% of the input's maximum.
%__________________________________________________________________________
% Copyright (C) 1994-2013 Wellcome Trust Centre for Neuroimaging

% Karl Friston
% $Id: spm_grid.m 5219 2013-01-29 17:07:07Z spm $

GRID  = 0.1;

load(fullfile(spm('dir'),'Grid.mat'),'i','j');
[x,y] = size(I);
i     = round(1 + (i - 1)*(x - 1)/64);
j     = round(1 + (j - 1)*(y - 1)/86);
G     = full(sparse(i,j,max(I(:))*GRID*ones(length(i),1)));
I     = max(I,G);
