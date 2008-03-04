function dep = cfg_dep_add(dep, cdep, ntgt_input, njtsubs)

% augment cdep tsubs references, and add them to dependency list
%
% This code is part of a batch job configuration system for MATLAB. See 
%      help matlabbatch
% for a general overview.
%_______________________________________________________________________
% Copyright (C) 2007 Freiburg Brain Imaging

% Volkmar Glauche
% $Id: cfg_dep_add.m 1184 2008-03-04 16:27:57Z volkmar $

rev = '$Rev: 1184 $';

if isempty(cdep)
    return;
end;
for k = 1:numel(cdep)
    cdep(k).tgt_input = [ntgt_input cdep(k).tgt_input];
    cdep(k).jtsubs = [njtsubs cdep(k).jtsubs];
end;
if isempty(dep)
    dep = cdep(:);
else
    dep = [dep(:) cdep(:)];
end;
