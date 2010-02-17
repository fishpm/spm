function invert = spm_cfg_eeg_inv_invert
% configuration file for configuring imaging source inversion
% reconstruction
%_______________________________________________________________________
% Copyright (C) 2010 Wellcome Trust Centre for Neuroimaging

% Vladimir Litvak
% $Id: spm_cfg_eeg_inv_invert.m 3731 2010-02-17 14:45:18Z vladimir $

D = cfg_files;
D.tag = 'D';
D.name = 'M/EEG datasets';
D.filter = 'mat';
D.num = [1 Inf];
D.help = {'Select the M/EEG mat files.'};

val = cfg_entry;
val.tag = 'val';
val.name = 'Inversion index';
val.strtype = 'n';
val.help = {'Index of the cell in D.inv where the forward model can be found and the results will be stored.'};
val.val = {1};

all = cfg_const;
all.tag = 'all';
all.name = 'All';
all.val  = {1};

condlabel = cfg_entry;
condlabel.tag = 'condlabel';
condlabel.name = 'Condition label';
condlabel.strtype = 's';
condlabel.val = {''};

conditions = cfg_repeat;
conditions.tag = 'conditions';
conditions.name = 'Conditions';
conditions.help = {'Specify the labels of the conditions to be included in the inversion'};
conditions.num  = [1 Inf];
conditions.values  = {condlabel};
conditions.val = {condlabel};

whatconditions = cfg_choice;
whatconditions.tag = 'whatconditions';
whatconditions.name = 'What conditions to include?';
whatconditions.values = {all, conditions};
whatconditions.val = {all};

standard = cfg_const;
standard.tag = 'standard';
standard.name = 'Standard';
standard.help = {'Use default settings for the inversion'};
standard.val  = {1};

invtype = cfg_menu;
invtype.tag = 'invtype';
invtype.name = 'Inversion type';
invtype.help = {'Select the desired inversion type'};
invtype.labels = {'MSP (GS)', 'ARD', 'COH', 'IID'};
invtype.values = {'GS', 'ARD', 'LOR', 'IID'};
invtype.val = {'GS'};

woi = cfg_entry;
woi.tag = 'woi';
woi.name = 'Time window of interest';
woi.strtype = 'r';
woi.num = [1 2];
woi.val = {[-Inf Inf]};
woi.help = {'Time window to include in the inversion (ms)'};

foi = cfg_entry;
foi.tag = 'foi';
foi.name = 'Frequency window of interest';
foi.strtype = 'r';
foi.num = [1 2];
foi.val = {[0 256]};
foi.help = {'Frequency window (the same as high-pass and low-pass in the GUI)'};

hanning = cfg_menu;
hanning.tag = 'hanning';
hanning.name = 'PST Hanning window';
hanning.help = {'Multiply the time series by a Hanning taper to emphasize the central part of the response.'};
hanning.labels = {'yes', 'no'};
hanning.values = {1, 0};
hanning.val = {1};

priors  = cfg_files;
priors.tag = 'priors';
priors.name = 'Source priors';
priors.filter = '(.*\.gii$)|(.*\.mat$)|(.*\.nii(,\d+)?$)|(.*\.img(,\d+)?$)';
priors.num = [1 1];
priors.help = {'Select a mask or a mat file with priors.'};
priors.val = {''};

locs  = cfg_entry;
locs.tag = 'locs';
locs.name = 'Source locations';
locs.strtype = 'r';
locs.num = [Inf 3];
locs.help = {'Input source locations as n x 3 matrix'};
locs.val = {zeros(0, 3)};

radius = cfg_entry;
radius.tag = 'radius';
radius.name = 'Radius of VOI (mm)';
radius.strtype = 'r';
radius.num = [1 1];
radius.val = {32};

restrict = cfg_branch;
restrict.tag = 'restrict';
restrict.name = 'Restrict solutions';
restrict.help = {'Restrict solutions to pre-specified VOIs'};
restrict.val  = {locs, radius};

custom = cfg_branch;
custom.tag = 'custom';
custom.name = 'Custom';
custom.help = {'Define custom settings for the inversion'};
custom.val  = {invtype, woi, foi, hanning, priors, restrict};

isstandard = cfg_choice;
isstandard.tag = 'isstandard';
isstandard.name = 'Inversion parameters';
isstandard.help = {'Choose whether to use standard or custom inversion parameters.'};
isstandard.values = {standard, custom};
isstandard.val = {standard};

modality = cfg_menu;
modality.tag = 'modality';
modality.name = 'Select modalities';
modality.help = {'Select modalities for the inversion (only relevant for multimodal datasets).'};
modality.labels = {'All', 'EEG', 'MEG', 'MEGPLANAR', 'EEG+MEG', 'MEG+MEGPLANAR', 'EEG+MEGPLANAR'};
modality.values = {
    {'All'}
    {'EEG'}
    {'MEG'}
    {'MEGPLANAR'}
    {'EEG', 'MEG'}
    {'MEG', 'MEGPLANAR'}
    {'EEG', 'MEGPLANAR'}
    }';
modality.val = {{'All'}};

invert = cfg_exbranch;
invert.tag = 'invert';
invert.name = 'M/EEG source inversion';
invert.val = {D, val, whatconditions, isstandard, modality};
invert.help = {'Run imaging source reconstruction'};
invert.prog = @run_inversion;
invert.vout = @vout_inversion;
invert.modality = {'EEG'};

function  out = run_inversion(job)

D = spm_eeg_load(job.D{1});

inverse = [];
if isfield(job.whatconditions, 'conditions')
    inverse.trials = {job.whatconditions.conditions(:).condlabel};
end

if isfield(job.isstandard, 'custom')
    inverse.type = job.isstandard.custom.invtype;
    inverse.woi  = fix([max(min(job.isstandard.custom.woi), 1000*D.time(1)) min(max(job.isstandard.custom.woi), 1000*D.time(end))]);
    inverse.Han  = job.isstandard.custom.hanning;
    inverse.lpf  =  fix(min(job.isstandard.custom.foi));
    inverse.hpf  =  fix(max(job.isstandard.custom.foi));
    
    if ~isempty(job.isstandard.custom.priors)
        P = job.isstandard.custom.priors;
        [p,f,e] = fileparts(P);
        switch lower(e)
            case '.gii'
                g = gifti(P);
                inverse.pQ = cell(1,size(g.cdata,2));
                for i=1:size(g.cdata,2)
                    inverse.pQ{i} = double(g.cdata(:,i));
                end
            case '.mat'
                load(P);
                inverse.pQ = pQ;
            case {'.img', '.nii'}
                S.D = D;
                S.fmri = P;
                D = spm_eeg_inv_fmripriors(S);
                inverse.fmri = D.inv{D.val}.inverse.fmri;
                load(inverse.fmri.priors);
                inverse.pQ = pQ;
            otherwise
                error('Unknown file type.');
        end
    end
    
    if ~isempty(job.isstandard.custom.restrict.locs)
        inverse.xyz = job.isstandard.custom.restrict.locs;
        inverse.rad = job.isstandard.custom.restrict.radius;
    end
end

[mod, list] = modality(D, 1, 1);
if strcmp(job.modality{1}, 'All')
    inverse.modality  = list;
else
    inverse.modality  = intersect(list, job.modality);
end

if numel(inverse.modality) == 1
    inverse.modality = inverse.modality{1};
end

D = {};

for i = 1:numel(job.D)
    D{i} = spm_eeg_load(job.D{i});
    
    D{i}.val = job.val;
    
    D{i}.con = 1;
    
    if ~isfield(D{i}.inv{D{i}.val}, 'forward')
        error(sprintf('Forward model is missing for subject %d', i));
    end
    
    D{i}.inv{D{i}.val}.inverse = inverse;
end

D = spm_eeg_invert(D);

if ~iscell(D)
    D = {D};
end

for i = 1:numel(D)
    save(D{i});
end

out.D = job.D;

function dep = vout_inversion(job)
% Output is always in field "D", no matter how job is structured
dep = cfg_dep;
dep.sname = 'M/EEG dataset(s) after imaging source reconstruction';
% reference field "D" from output
dep.src_output = substruct('.','D');
% this can be entered into any evaluated input
dep.tgt_spec   = cfg_findspec({{'filter','mat'}});

