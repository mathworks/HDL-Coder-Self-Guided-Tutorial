%
% Copyright 2019 The MathWorks, Inc.
%
function demoMode(varargin)
% demoMode or demoMode('on') adds the folder containing the solution models
% to MATLAB path. The folder is not added if any of the models is already
% on the path.
%
% demoMode('off') removes the folder from MATLAB path.

if nargin == 0
    mode_flag = 'on';
elseif nargin == 1
    mode_flag = varargin{:};
else
    error('Too many input arguments, only 0 or 1 expected.');
end

switch lower(mode_flag)
    case 'on'
        m1 = which('pulse_detector_v1.slx');
        m2 = which('pulse_detector_v2.slx');
        m3 = which('pulse_detector_v3.slx');
        if ~isempty(m1)
            error('Model already exists:\n%s',m1); 
        elseif ~isempty(m2)
            error('Model already exists:\n%s',m2); 
        elseif ~isempty(m3)
            error('Model already exists:\n%s',m3); 
        else
            addpath('../solution');
            disp('Added model folder ../solution to path');
        end
            
    case 'off'
        rmpath('../solution');
        disp('Removed folder ../solution from path');
    otherwise
        error('Undefined input argument');
end
