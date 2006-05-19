function opts = spm_config_cd
% Configuration file for changing directory function
%_______________________________________________________________________
% Copyright (C) 2005 Wellcome Department of Imaging Neuroscience

% Darren Gitelmann
% $Id: spm_config_cd.m 538 2006-05-19 08:05:24Z volkmar $

data.type = 'files';
data.name = 'Select a directory';
data.tag  = 'directory';
data.filter = 'dir';
data.num  = 1;
data.help = {'Select a directory to change to.'};

opts.type = 'branch';
opts.name = 'Change Directory';
opts.tag  = 'cdir';
opts.val  = {data};
opts.prog = @my_cd;
p1 = [...
'This facilty allows programming a directory change. Directories are ',...
'selected in the right listbox.'];

opts.help = {p1};

%------------------------------------------------------------------------

%------------------------------------------------------------------------
function my_cd(varargin)
job = varargin{1};
if ~isempty(job.directory),
    cd(job.directory{:});
    fprintf('New working directory: %s\n', job.directory{:});
end;
return;
