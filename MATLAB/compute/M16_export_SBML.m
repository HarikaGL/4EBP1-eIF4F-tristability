%% M16  The model in SBML (Methods, "Model and code availability"): writes the complete network and the network
%  without the scaffold, with the reference parameters, as SBML Level 3 Version 2 files in Code_availability/SBML/.
%  Check: the full ODEs of the SBML file are the same as p4e_rhs; the script integrates p4e_rhs from the same initial
%  state (the repressed state at kin_T = 66 nM, and at 2 x SN3) and prints e4F at 1, 10 and 100 h, to compare with any
%  SBML simulator (COPASI, libRoadRunner, MATLAB SimBiology sbmlimport).
%  Run time: seconds. Output: SBML/p4e_full.xml, SBML/p4e_noscaffold.xml.
clearvars; here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); setup_p4e(); OUT = fullfile(here, '..', '..', 'SBML'); if ~exist(OUT, 'dir'), mkdir(OUT); end
P = p4e_ref(); kin = 66;
p4e_write_sbml(P, kin, fullfile(OUT, 'p4e_full.xml'), true, 'p4e_full');
p4e_write_sbml(P, kin, fullfile(OUT, 'p4e_noscaffold.xml'), false, 'p4e_noscaffold');
fprintf('written: %s\n         %s\n', fullfile(OUT, 'p4e_full.xml'), fullfile(OUT, 'p4e_noscaffold.xml'));
for k = [kin 230.4]
    [t, F] = p4e_det_traj(P, k, [], 100*3600);
    fprintf('p4e_rhs, kin_T = %.1f nM, from the repressed state: e4F = %.4g, %.4g, %.4g nM at 1, 10, 100 h\n', k, interp1(t, F, [1 10 100]*3600));
end
