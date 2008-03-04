function [sts val] = subsasgn_check(item,subs,val)

% function [sts val] = subsasgn_check(item,subs,val)
% Do a check for proper assignments of values to fields. This routine
% will be called for derived objects from @cfg_.../subsasgn with the
% original object as first argument and the proposed subs and val fields
% before an assignment is made. It is up to each derived class to
% implement assignment checks for both its own fields and fields
% inherited from cfg_item. If used for assignment checks for inherited
% fields, these must be dealt with in special cases in @cfg_.../subsasgn
% 
% This routine is a both a check for cfg_item fields and a fallback
% placeholder in cfg_item if a derived class does not implement its own
% checks. In this case it always returns true.
%
% This code is part of a batch job configuration system for MATLAB. See 
%      help matlabbatch
% for a general overview.
%_______________________________________________________________________
% Copyright (C) 2007 Freiburg Brain Imaging

% Volkmar Glauche
% $Id: subsasgn_check.m 1184 2008-03-04 16:27:57Z volkmar $

rev = '$Rev: 1184 $';

sts = true;
checkstr = sprintf('Item ''%s'', field ''%s''', subsref(item,substruct('.','name')), subs(1).subs);
switch class(item)
    case {'cfg_item'}
        % do subscript checking for base class
        switch subs(1).subs
            case {'tag', 'name'},
                if ~ischar(val)
                    warning('matlabbatch:cfg_item:subsasgn_check:tagname', '%s: Value must be a string.', checkstr);
                    sts = false;
                end;
            case {'val'},
                % Check match of a dependency. Other item-specific checks
                % are performed in an item's subsasgn_check.
                if isa(val, 'cfg_dep')
                    sts = match(item, cfg_dep.tgt_spec);
                    if ~sts
                        warning('matlabbatch:cfg_item:subsasgn_check:depmatch', '%s: Dependency does not match.', checkstr);
                    end;
                end;
            case {'check'},
                if ~subsasgn_check_funhandle(val)
                    warning('matlabbatch:cfg_item:subsasgn_check:check', '%s: Value must be a function or function handle.', checkstr);
                    sts = false;
                end;
            case {'help'},
                if isempty(val)
                    val = {};
                else
                    if ~iscellstr(val)
                        warning('matlabbatch:cfg_item:subsasgn_check:help', '%s: Value must be a cell string.', checkstr);
                        sts = false;
                    end;
                end;
            case {'id', 'hidden', 'expanded'},
        end;
    otherwise
        % fall back for derived classes
        sts = true;
end;
