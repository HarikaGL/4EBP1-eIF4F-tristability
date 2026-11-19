function R = setup_p4e()
%SETUP_P4E  Add the model folder to the path and return the folder for results (created if needed).
%   Every compute script calls this first. Works in MATLAB (R2016b or later) and GNU Octave; no toolbox needed.
here = fileparts(mfilename('fullpath'));
addpath(fullfile(here, 'model'));
R = fullfile(here, 'Results'); if ~exist(R, 'dir'), mkdir(R); end
end
