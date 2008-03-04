function fnames = mysubs_fields(dep)

% This function returns a cell string of names containing the fields
% implemented by the cfg_dep class. It is called from @cfg_dep/subsasgn
% and @cfg_item/subsref to allow references to valid fields for this class.
%
% This code is part of a batch job configuration system for MATLAB. See 
%      help matlabbatch
% for a general overview.
%_______________________________________________________________________
% Copyright (C) 2007 Freiburg Brain Imaging

% Volkmar Glauche
% $Id: mysubs_fields.m 1184 2008-03-04 16:27:57Z volkmar $

rev = '$Rev: 1184 $';

fnames = {'tname','tgt_exbranch','tgt_input','tgt_spec','jtsubs','sname','src_exbranch','src_output'};