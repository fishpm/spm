function [x, y] = ft_select_box(handle, eventdata, varargin)

% FT_SELECT_BOX helper function for selecting a rectangular region
% in the current figure using the mouse.
%
% Use as
%   [x, y] = ft_select_box(...)
%
% It returns a 2-element vector x and a 2-element vector y
% with the corners of the selected region.
%
% Optional input arguments should come in key-value pairs and can include
%   'multiple'   true/false, make multiple selections by dragging, clicking
%                in one will finalize the selection (default = false)

% Copyright (C) 2006, Robert Oostenveld
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
% $Id: ft_select_box.m 4384 2011-10-08 12:00:17Z roboos $

% get the optional arguments
multiple = ft_getopt(varargin, 'multiple', false);

if istrue(multiple)
  error('not yet implemented');
else
  k = waitforbuttonpress;
  point1 = get(gca,'CurrentPoint');    % button down detected
  finalRect = rbbox;                   % return figure units
  point2 = get(gca,'CurrentPoint');    % button up detected
  point1 = point1(1,1:2);              % extract x and y
  point2 = point2(1,1:2);
  x = sort([point1(1) point2(1)]);
  y = sort([point1(2) point2(2)]);
end


