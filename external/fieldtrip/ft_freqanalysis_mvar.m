function [freq] = ft_freqanalysis_mvar(cfg, data)

% FT_FREQANALYSIS_MVAR performs frequency analysis on
% mvar data, by fourier transformation of the coefficients. The output
% contains cross-spectral density, spectral transfer matrix, and the
% covariance of the innovation noise. The dimord = 'chan_chan(_freq)(_time)
%
% The function is stand-alone, but is typically called through
% FT_FREQANALYSIS, specifying cfg.method = 'mvar'.
%
% Use as
%   [freq] = ft_freqanalysis(cfg, data), with cfg.method = 'mvar'
%
% or
% 
%   [freq] = ft_freqanalysis_mvar(cfg, data)
%
% The input data structure should be a data structure created by
% FT_MVARANALYSIS, i.e. a data-structure of type 'mvar'. 
%
% The configuration can contain:
%   cfg.foi = vector with the frequencies at which the spectral quantities
%               are estimated (in Hz). Default: 0:1:Nyquist
%   cfg.feedback = 'none', or any of the methods supported by FT_PROGRESS,
%                    for providing feedback to the user in the command
%                    window.
%
% To facilitate data-handling and distributed computing with the peer-to-peer
% module, this function has the following options:
%   cfg.inputfile   =  ...
%   cfg.outputfile  =  ...
% If you specify one of these (or both) the input data will be read from a *.mat
% file on disk and/or the output data will be written to a *.mat file. These mat
% files should contain only a single variable, corresponding with the
% input/output structure.
%
% See also FT_MVARANALYSIS, FT_DATATYPE_MVAR, FT_PROGRESS

% Copyright (C) 2009, Jan-Mathijs Schoffelen
%
% This file is part of FieldTrip, see http://www.ru.nl/neuroimaging/fieldtrip
% for the documentation and details.
%
%    FieldTrip is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    FieldTrip is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with FieldTrip. If not, see <http://www.gnu.org/licenses/>.
%
% $Id: ft_freqanalysis_mvar.m 6750 2012-10-13 15:07:32Z roboos $

revision = '$Id: ft_freqanalysis_mvar.m 6750 2012-10-13 15:07:32Z roboos $';

% do the general setup of the function
ft_defaults
ft_preamble help
ft_preamble provenance
ft_preamble trackconfig
ft_preamble loadvar data

cfg.foi        = ft_getopt(cfg, 'foi',        'all');
cfg.feedback   = ft_getopt(cfg, 'feedback',   'none');
%cfg.channel    = ft_getopt(cfg, 'channel',    'all');
%cfg.keeptrials = ft_getopt(cfg, 'keeptrials', 'no');
%cfg.jackknife  = ft_getopt(cfg, 'jackknife',  'no');
%cfg.keeptapers = ft_getopt(cfg, 'keeptapers', 'yes');

if strcmp(cfg.foi, 'all'),
  cfg.foi = (0:1:data.fsampleorig/2);
end

cfg.channel = ft_channelselection('all', data.label);
%cfg.channel    = ft_channelselection(cfg.channel,      data.label);

%keeprpt  = strcmp(cfg.keeptrials, 'yes');
%keeptap  = strcmp(cfg.keeptapers, 'yes');
%dojack   = strcmp(cfg.jackknife,  'yes');
%dozscore = strcmp(cfg.zscore,     'yes');

%if ~keeptap, error('not keeping tapers is not possible yet'); end
%if dojack && keeprpt, error('you cannot simultaneously keep trials and do jackknifing'); end

nfoi     = length(cfg.foi);
if isfield(data, 'time')
  ntoi = numel(data.time);
else
  ntoi = 1;
end
nlag     = size(data.coeffs,3); %change in due course
chanindx = match_str(data.label, cfg.channel);
nchan    = length(chanindx);
label    = data.label(chanindx);

%---allocate memory
h         = complex(zeros(nchan, nchan,  nfoi, ntoi), zeros(nchan, nchan,  nfoi, ntoi));
a         = complex(zeros(nchan, nchan,  nfoi, ntoi), zeros(nchan, nchan,  nfoi, ntoi));
crsspctrm = complex(zeros(nchan, nchan,  nfoi, ntoi), zeros(nchan, nchan,  nfoi, ntoi));

%FIXME build in repetitions

%---loop over the tois
ft_progress('init', cfg.feedback, 'computing MAR-model based TFR');
for j = 1:ntoi
  ft_progress(j/ntoi, 'processing timewindow %d from %d\n', j, ntoi);
 
  %---compute transfer function
  ar = reshape(data.coeffs(:,:,:,j), [nchan nchan*nlag]);
  [h(:,:,:,j), a(:,:,:,j)] = ar2h(ar, cfg.foi, data.fsampleorig);

  %---compute cross-spectra
  nc = data.noisecov(:,:,j);
  for k = 1:nfoi
    tmph               = h(:,:,k,j);
    crsspctrm(:,:,k,j) = tmph*nc*tmph';
  end
end  
ft_progress('close');

%---create output-structure
freq          = [];
freq.label    = label;
freq.freq     = cfg.foi;
%freq.cumtapcnt= ones(ntrl, 1)*ntap;
if ntoi>1
  freq.time   = data.time;
  freq.dimord = 'chan_chan_freq_time';
else
  freq.dimord = 'chan_chan_freq';
end
freq.transfer  = h;
%freq.itransfer = a;
freq.noisecov  = data.noisecov;
freq.crsspctrm = crsspctrm;
freq.dof       = data.dof;

% do the general cleanup and bookkeeping at the end of the function
ft_postamble trackconfig
ft_postamble provenance
ft_postamble previous data
ft_postamble history freq
ft_postamble savevar freq

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SUBFUNCTION to compute transfer-function from ar-parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [h, zar] = ar2h(ar, foi, fsample)

nchan = size(ar,1);
ncmb  = nchan*nchan;
nfoi  = length(foi);

%---z-transform frequency axis
zfoi  = exp(-2.*pi.*1i.*(foi./fsample));

%---reorganize the ar-parameters
ar  = reshape(ar, [ncmb size(ar,2)./nchan]);
ar  = fliplr([reshape(eye(nchan), [ncmb 1]) -ar]);

zar = complex(zeros(ncmb, nfoi), zeros(ncmb, nfoi));
for k = 1:ncmb
  zar(k,:) = polyval(ar(k,:),zfoi);
end
zar = reshape(zar, [nchan nchan nfoi]);
h   = zeros(size(zar));
for k = 1:nfoi
  h(:,:,k) = inv(zar(:,:,k)); 
end
h   = sqrt(2).*h; %account for the negative frequencies, normalization necessary for
%comparison with non-parametric (fft based) results in fieldtrip
%FIXME probably the normalization for the zero Hz bin is incorrect
zar = zar./sqrt(2);
