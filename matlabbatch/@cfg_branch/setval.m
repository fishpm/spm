function item = setval(item, val)

% function item = setval(item, val)
% prevent changes to item.val via setval for branches
%
% This code is part of a batch job configuration system for MATLAB. See 
%      help matlabbatch
% for a general overview.
%_______________________________________________________________________
% Copyright (C) 2007 Freiburg Brain Imaging

% Volkmar Glauche
% $Id: setval.m 1184 2008-03-04 16:27:57Z volkmar $

rev = '$Rev: 1184 $';

warning('matlabbatch:cfg_branch:setval', 'Setting val{} of branch items via setval() not permitted.');