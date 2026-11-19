%RUN_ALL  Run every compute script in order (see README.md for what each produces and how long it takes).
%   Set QUICK = true before calling run_all for a fast test of all scripts.
here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
S = {'M01_parameters_thermodynamics', 'M02_modules_and_ingredients', 'M03_reference_set', ...
     'M04_scaffold_prozone', 'M05_with_without_scaffold', 'M06_driving_strength_ATP', 'M07_eIF4E_knockdown', ...
     'M08_single_parameter_LHS', 'M09_accessible_kinase_range', 'M10_ensembles', ...
     'M11_Gillespie_reference', 'M12_Gillespie_edge_sets', ...
     'M13_switching_timescale', 'M15_global_sensitivity_PRCC', 'M16_export_SBML', 'M17_reaction_loops'};
if ~exist('QUICK', 'var'), QUICK = false; end
for i = 1:numel(S)
    fprintf('\n================ %s ================\n', S{i});
    save(fullfile(tempdir, 'p4e_run_all.mat'), 'S', 'i', 'QUICK', 'here');
    run(fullfile(here, 'compute', [S{i} '.m']));
    load(fullfile(tempdir, 'p4e_run_all.mat'));
end
