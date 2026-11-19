function p4e_write_sbml(P, kinT, file, scaffold, name)
%P4E_WRITE_SBML  Write the mass-action model R1-R22 (all 44 elementary reactions, no reduction) as SBML Level 3
%   Version 2 (M16). Concentrations in nM, time in s, first-order constants in s^-1, second-order in nM^-1 s^-1.
%   The compartment has volume 1 (litre) and the substance unit is the nanomole, so every species value is a
%   concentration in nM. Each reaction R_j is reversible with rate  kf_j*[reactants] - kb_j*[products].
%   Initial state: the repressed state at total kinase kinT (all eIF4E bound to unphosphorylated 4E-BP, free
%   kinase = kinT, free phosphatase = P_T, free eIF4G and eIF4A at their totals). scaffold = false removes
%   eIF4G, eIF4A and R18-R21 (the network without the scaffold; read-out free eIF4E).
if nargin < 4, scaffold = true; end
if nargin < 5, name = 'p4e_4EBP1_eIF4F'; end
[A, S] = p4e_ssa_tables();
sp = {'kin', 'Total kinase (mTORC1) free'; 'Ptase', 'Phosphatase free'; 'e4E', 'eIF4E free'; 'BP', '4E-BP1 free, unphosphorylated'; ...
      'e4G', 'eIF4G free'; 'e4A', 'eIF4A free'; 'S0', 'eIF4E:4E-BP1 (unphosphorylated)'; 'S1', 'eIF4E:4E-BP1, 1 stage-1 site'; ...
      'S2', 'eIF4E:4E-BP1, both stage-1 sites'; 'S3', 'eIF4E:4E-BP1, stage 1 + one stage-2 site'; 'S4', 'eIF4E:4E-BP1, fully phosphorylated'; ...
      'BPp4', '4E-BP1 fully phosphorylated, free'; 'C1', 'kinase:S0'; 'C2', 'kinase:S1'; 'C3', 'phosphatase:S2'; 'C4', 'phosphatase:S1'; ...
      'C5', 'kinase:S2'; 'C6', 'kinase:S3'; 'C7', 'phosphatase:S4'; 'C8', 'phosphatase:S3'; 'e4GE', 'eIF4G:eIF4E'; 'e4GA', 'eIF4G:eIF4A'; ...
      'e4F', 'eIF4F (eIF4E:eIF4G:eIF4A)'};
x0 = zeros(23, 1); tot = P.tot; nb = min(tot(1), tot(2));
x0(1) = kinT; x0(2) = tot(3); x0(3) = tot(1) - nb; x0(4) = tot(2) - nb; x0(5) = tot(4); x0(6) = tot(5); x0(7) = nb;
rx = 1:22; use = true(23, 1);
if ~scaffold, rx = [1:17 22]; use([5 6 21 22 23]) = false; end
fid = fopen(file, 'w');
w = @(varargin) fprintf(fid, varargin{:});
w('<?xml version="1.0" encoding="UTF-8"?>\n');
w('<sbml xmlns="http://www.sbml.org/sbml/level3/version2/core" level="3" version="2">\n');
w('  <model id="%s" name="4E-BP1 phosphorylation and eIF4F assembly (R1-R22)" substanceUnits="nanomole" timeUnits="second" volumeUnits="litre" extentUnits="nanomole">\n', name);
w('    <notes><body xmlns="http://www.w3.org/1999/xhtml"><p>Mass-action model of staged 4E-BP1 phosphorylation by mTORC1, eIF4E release and eIF4F assembly (Harika and Sriram). Reference parameter set; rate constants obey the thermodynamic cycle condition (Eq 1). Total kinase kin_T = %g nM. Concentrations nM, time s.</p></body></notes>\n', kinT);
w('    <listOfUnitDefinitions>\n');
w('      <unitDefinition id="nanomole"><listOfUnits><unit kind="mole" exponent="1" scale="-9" multiplier="1"/></listOfUnits></unitDefinition>\n');
w('      <unitDefinition id="per_second"><listOfUnits><unit kind="second" exponent="-1" scale="0" multiplier="1"/></listOfUnits></unitDefinition>\n');
w('      <unitDefinition id="per_nM_per_second"><listOfUnits><unit kind="mole" exponent="-1" scale="-9" multiplier="1"/><unit kind="litre" exponent="1" scale="0" multiplier="1"/><unit kind="second" exponent="-1" scale="0" multiplier="1"/></listOfUnits></unitDefinition>\n');
w('    </listOfUnitDefinitions>\n');
w('    <listOfCompartments>\n      <compartment id="cell" spatialDimensions="3" size="1" units="litre" constant="true"/>\n    </listOfCompartments>\n');
w('    <listOfSpecies>\n');
for i = find(use)'
    w('      <species id="%s" name="%s" compartment="cell" initialConcentration="%.10g" substanceUnits="nanomole" hasOnlySubstanceUnits="false" boundaryCondition="false" constant="false"/>\n', sp{i, 1}, sp{i, 2}, x0(i));
end
w('    </listOfSpecies>\n    <listOfParameters>\n');
for j = rx
    for d = 0:1
        r = 2*j - 1 + d; u = 'per_second'; if nnz(A(r, :)) == 2, u = 'per_nM_per_second'; end
        if d == 0, nm = sprintf('kf%d', j); v = P.kf(j); else, nm = sprintf('kb%d', j); v = P.kb(j); end
        w('      <parameter id="%s" value="%.17g" units="%s" constant="true"/>\n', nm, v, u);
    end
end
w('      <parameter id="kinT" value="%.10g" units="nanomole" constant="true"/>\n', kinT);
w('    </listOfParameters>\n    <listOfReactions>\n');
for j = rx
    r = 2*j - 1; re = find(S(:, r) < 0); pr = find(S(:, r) > 0);
    w('      <reaction id="R%d" reversible="true">\n        <listOfReactants>\n', j);
    for s = re', w('          <speciesReference species="%s" stoichiometry="%d" constant="true"/>\n', sp{s, 1}, -S(s, r)); end
    w('        </listOfReactants>\n        <listOfProducts>\n');
    for s = pr', w('          <speciesReference species="%s" stoichiometry="%d" constant="true"/>\n', sp{s, 1}, S(s, r)); end
    w('        </listOfProducts>\n        <kineticLaw>\n          <math xmlns="http://www.w3.org/1998/Math/MathML">\n');
    w('            <apply><times/><ci>cell</ci><apply><minus/>%s%s</apply></apply>\n', term(sprintf('kf%d', j), sp(re, 1)), term(sprintf('kb%d', j), sp(pr, 1)));
    w('          </math>\n        </kineticLaw>\n      </reaction>\n');
end
w('    </listOfReactions>\n  </model>\n</sbml>\n');
fclose(fid);
end

function s = term(k, names)
s = ['<apply><times/><ci>' k '</ci>'];
for i = 1:numel(names), s = [s '<ci>' names{i} '</ci>']; end %#ok<AGROW>
s = [s '</apply>'];
end
