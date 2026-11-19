%RUN_ALL  Run every compute script in order (see README.md for what each produces and how long it takes).
%   Set QUICK = true before calling run_all for a fast test of all scripts.
here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
S = {'M01_Table1_Table7_parameters', 'M02_Fig2_modules_and_ingredients', 'M03_Fig3_Table2_Table3_reference', ...
     'M04_Fig4_scaffold_prozone', 'M05_Fig5_with_without_scaffold', 'M06_driving_strength_ATP', 'M07_Fig6_eIF4E_knockdown', ...
     'M08_Fig8_Table5_single_parameter_LHS', 'M09_Fig9_accessible_kinase_range', 'M10_Fig7_Fig10_Fig11_Table6_ensembles', ...
     'M11_Fig12_Gillespie_reference', 'M12_Fig13_Fig14_Gillespie_edge_sets', ...
     'M13_switching_timescale', 'M15_global_sensitivity_PRCC', 'M16_export_SBML', 'M17_reaction_loops'};
if ~exist('QUICK', 'var'), QUICK = false; end
for i = 1:numel(S)
    fprintf('\n================ %s ================\n', S{i});
    save(fullfile(tempdir, 'p4e_run_all.mat'), 'S', 'i', 'QUICK', 'here');
    run(fullfile(here, 'compute', [S{i} '.m']));
    load(fullfile(tempdir, 'p4e_run_all.mat'));
end
