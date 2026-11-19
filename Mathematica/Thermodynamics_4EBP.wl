(* ::Package:: *)
(* Thermodynamics_4EBP.wl: the same cells as Thermodynamics_4EBP.nb, as a plain-text Wolfram Language script. *)

(* ::Title:: *)
(*Thermodynamics of the 4E-BP1 / eIF4F model: every derivation and calculation, step by step*)

(* ::Text:: *)
(*Companion to: Harika GL, Sriram K. Staged 4E-BP1 phosphorylation creates two switches in series that give eIF4F memory (npj Systems Biology and Applications version). Each section names the equation, section, note or table of the manuscript that it derives or computes. Run the cells one by one, from the top (Shift+Enter), or all at once (Evaluation > Evaluate Notebook). Text in blue explains the cell below it. Units: concentrations in nM, first-order constants in 1/s, second-order constants in 1/(nM s).*)

(* ::Text:: *)
(*Map to the manuscript. Sections 1-4: Supplementary Note 2, Steps 1-6; Methods 4.2, Steps 1-4; Results 2.2, Eq (1). Section 5: Supplementary Note 2, Steps 7-8; Methods 4.2, Step 5. Section 6: Supplementary Table 5. Section 7: Methods 4.2, Step 6; Eq (2); Supplementary Table 7. Section 8: Results 2.6 (driving strength). Sections 9-11: Supplementary Note 3; Supplementary Figs 9-11; Supplementary Table 8. Section 12: the split parameter u, Supplementary Note 2, Steps 9-14; Supplementary Table 6; Methods 4.2.*)

(* ::Section:: *)
(*0. Reference parameter set (Table 3, Methods 4.1; MATLAB model/p4e_ref.m)*)

(* ::Text:: *)
(*Clear any earlier definitions so that the notebook can be rerun from the top.*)

ClearAll["Global`*"]


(* ::Text:: *)
(*The 22 forward and 22 backward rate constants of R1-R22 at the reference set, in the order R1, R2, ..., R22. The backward constants of the catalytic steps (R2, R4, ..., R16) and kb21 are the values computed below (Sections 5-7); they are listed here so that every check can be made against the numbers used in the simulations.*)

kfRef = {0.031, 0.0029, 0.1, 17.0, 0.023, 0.027, 0.03, 0.14, 0.1, 0.002, 0.013, 30.0, 0.02, 0.24, 0.012, 0.15, 10.0, 0.095, 0.061, 0.076, 0.0065, 0.1};
kbRef = {0.11, 1.8118049126429878*10^(-8), 0.032, 5.248190926288552*10^(-6), 0.63, 2.5119421075763224*10^(-5), 5.5, 8.671843526089229*10^(-8), 0.42, 1.2059530144173232*10^(-8), 1.2, 7.161218699078797*10^(-6), 0.016, 3.427574767082689*10^(-5), 3.1, 5.772054026273275*10^(-8), 0.0020408163265306124, 2.565, 14.03, 4.256, 0.7208035714285713, 0.5};
Length /@ {kfRef, kbRef}


(* ::Text:: *)
(*Gas constant, temperature (37 degC) and RT in kJ/mol (Methods 4.2: RT = 2.579 kJ/mol).*)

R = 8.314462618*10^-3; Tk = 310.15; RT = R Tk


(* ::Section:: *)
(*1. One reversible reaction (Supplementary Note 2, Step 3; Methods 4.2, Step 1)*)

(* ::Text:: *)
(*A reversible elementary reaction A + B <-> AB with forward constant kf and backward constant kb. By mass action, the one-way rates are vplus = kf [A][B] and vminus = kb [AB]; the net rate is r = vplus - vminus.*)

vplus = kf a b; vminus = kb ab; r = vplus - vminus


(* ::Text:: *)
(*At equilibrium r = 0. Solving for [AB] shows that [AB]/([A][B]) = kf/kb: the equilibrium constant is K = kf/kb for the reaction as written (for binding, K = 1/KD).*)

Solve[r == 0, ab]
Keq = ab/(a b) /. First[Solve[r == 0, ab]]


(* ::Text:: *)
(*Free energy. With chemical potentials mu = mu0 + RT Log[c], DeltaG = DeltaG0 + RT Log[Q], DeltaG0 = -RT Log[K], Q = [AB]/([A][B]). The cell checks that DeltaG equals -RT Log[vplus/vminus] (the difference simplifies to 0; the second line checks it numerically with random positive values): a reaction runs forward exactly when its DeltaG is negative.*)

Q = ab/(a b); dG0 = -rt Log[kf/kb]; dG = dG0 + rt Log[Q];
Simplify[PowerExpand[dG - (-rt Log[vplus/vminus])]]
Chop[dG - (-rt Log[vplus/vminus]) /. Thread[{kf, kb, a, b, ab, rt} -> RandomReal[{0.1, 10}, 6]]]


(* ::Section:: *)
(*2. Cycle 1: the four reactions and their one-way rates (Supplementary Note 2, Steps 1-2)*)

(* ::Text:: *)
(*Cycle 1 is the first phosphorylation site. R1: BPe4E + kin <-> C1 (kinase binding). R2: C1 <-> BPe4Ep + kin (catalysis). R7: BPe4Ep + P <-> C4 (phosphatase binding). R8: C4 <-> BPe4E + P (dephosphorylation). Symbols: s0 = [BPe4E], s1 = [BPe4Ep], k = [kin], p = [P], c1 = [C1], c4 = [C4]. In Eq (1), a = R1, b = R2, c = R7, d = R8.*)

v1p = kf1 s0 k; v1m = kb1 c1;
v2p = kf2 c1;   v2m = kb2 s1 k;
v7p = kf7 s1 p; v7m = kb7 c4;
v8p = kf8 c4;   v8m = kb8 s0 p;
TableForm[{{"R1", v1p, v1m}, {"R2", v2p, v2m}, {"R7", v7p, v7m}, {"R8", v8p, v8m}}, TableHeadings -> {None, {"reaction", "forward", "backward"}}]


(* ::Text:: *)
(*Reaction quotients of the four reactions (products over reactants).*)

q1 = c1/(s0 k); q2 = s1 k/c1; q7 = c4/(s1 p); q8 = s0 p/c4;


(* ::Section:: *)
(*3. Sum of the free energies around the cycle (Supplementary Note 2, Step 4; Eq S1)*)

(* ::Text:: *)
(*Adding the four free energies is the same as multiplying the four ratios vplus/vminus. Every concentration appears once above and once below the line and cancels, leaving only rate constants: this is Gamma1.*)

Gamma1 = Simplify[(v1p/v1m) (v2p/v2m) (v7p/v7m) (v8p/v8m)]


(* ::Text:: *)
(*Check that no concentration is left: the result does not depend on s0, s1, k, p, c1 or c4. The cancellation holds at every instant; no reaction has to be at equilibrium.*)

FreeQ[Gamma1, s0 | s1 | k | p | c1 | c4]


(* ::Text:: *)
(*The sum of the four free-energy changes equals -RT Log[Gamma1] (Eq S1): the difference simplifies to 0, and is 0 numerically for random positive values.*)

sumdG = -rt (Log[v1p/v1m] + Log[v2p/v2m] + Log[v7p/v7m] + Log[v8p/v8m]);
Simplify[PowerExpand[sumdG - (-rt Log[Gamma1])]]
Chop[sumdG - (-rt Log[Gamma1]) /. Thread[{kf1, kb1, kf2, kb2, kf7, kb7, kf8, kb8, s0, s1, k, p, c1, c4, rt} -> RandomReal[{0.1, 10}, 15]]]


(* ::Section:: *)
(*4. Half-cycles and ATP (Supplementary Note 2, Steps 5-6; Methods 4.2, Steps 3-4; Eq 1)*)

(* ::Text:: *)
(*Haldane relations: the kinase half-cycle (R1 then R2) converts BPe4E to BPe4Ep with overall constant Kkin = kf1 kf2/(kb1 kb2); the phosphatase half-cycle (R7 then R8) converts it back with Kp = kf7 kf8/(kb7 kb8). Their product is Gamma1.*)

Kkin1 = (kf1 kf2)/(kb1 kb2); Kp1 = (kf7 kf8)/(kb7 kb8);
Simplify[Kkin1 Kp1 == Gamma1]


(* ::Text:: *)
(*Where ATP enters. With the nucleotides explicit (primed constants), the kinase binds as kin-ATP and releases ADP at catalysis, and the phosphatase releases Pi. The model constants absorb the constant cellular levels: kf1 = kf1x [ATP], kb2 = kb2x [ADP], kb8 = kb8x [Pi]. With the nucleotides explicit the loop is closed and obeys detailed balance: its constant equals Khyd, the equilibrium constant of ATP hydrolysis.*)

explicit = {kf1 -> kf1x atp, kb2 -> kb2x adp, kb8 -> kb8x pi};
GammaExplicit = Gamma1 /. explicit


(* ::Text:: *)
(*Impose detailed balance on the explicit loop (kf1x kf2 kf7 kf8/(kb1 kb2x kb7 kb8x) = Khyd) and express Gamma1 through ATP, ADP and Pi: Gamma1 = Khyd [ATP]/([ADP][Pi]) = Exp[DeltaGc/RT] (Eq 1).*)

Simplify[GammaExplicit /. kf1x -> khyd kb1 kb2x kb7 kb8x/(kf2 kf7 kf8)]


(* ::Text:: *)
(*Size of DeltaGc. Illustration (Supplementary Note 2, Step 6): DeltaG0' of ATP hydrolysis = -30.5 kJ/mol, [ATP] = 3 mM, free [ADP] = 0.1 mM, [Pi] = 10 mM (concentrations in M for the standard state). DeltaGc = -DeltaG0' + RT Log[[ATP]/([ADP][Pi])].*)

dG0hyd = -30.5; atpM = 3*10^-3; adpM = 1*10^-4; piM = 10^-2;
ratio = atpM/(adpM piM)
dGc = -dG0hyd + RT Log[ratio]
lnGammaExample = dGc/RT


(* ::Text:: *)
(*The manuscript uses lnGamma = 19.8 for all four cycles: DeltaGc = RT x 19.8 (Methods 4.2, Step 4). The range DeltaGc = 50-55 kJ/mol corresponds to lnGamma = 19.4-21.3.*)

{RT 19.8, 50/RT, 55/RT}


(* ::Section:: *)
(*5. Cycle 1 with numbers: check and rebinding constants (Supplementary Note 2, Steps 7-8; Methods 4.2, Step 5)*)

(* ::Text:: *)
(*Reference constants of cycle 1 (Table 3).*)

num1 = {kf1 -> kfRef[[1]], kb1 -> kbRef[[1]], kf2 -> kfRef[[2]], kb2 -> kbRef[[2]], kf7 -> kfRef[[7]], kb7 -> kbRef[[7]], kf8 -> kfRef[[8]], kb8 -> kbRef[[8]]}


(* ::Text:: *)
(*Half-cycle constants, Gamma1, lnGamma1 = 19.80 and DeltaGc = RT lnGamma1 = 51.06 kJ/mol (Supplementary Note 2, Step 7; Methods 4.2, Step 5).*)

{Kkin1, Kp1, Gamma1} /. num1
{Log[Kkin1], Log[Kp1], Log[Gamma1], RT Log[Gamma1]} /. num1


(* ::Text:: *)
(*Computing the rebinding constants. kb2 and kb8 have not been measured. Setting Gamma1 = Exp[19.8] and solving for their product rho1 = kb2 kb8 gives rho1 = kf1 kf2 kf7 kf8/(kb1 kb7 Gamma) (Methods 4.2, Step 5, Eq for rho).*)

rhoSol = Solve[Gamma1 == gam /. kb8 -> rho/kb2, rho]
rho1 = rho /. First[rhoSol] /. gam -> Exp[19.8] /. num1


(* ::Text:: *)
(*The split u shares rho between kinase and phosphatase: kb2 = Sqrt[rho] 10^u, kb8 = Sqrt[rho] 10^-u, so kb2 kb8 = rho for any u. With u = -0.34 this gives the reference values 1.8118*10^-8 and 8.6718*10^-8 1/(nM s).*)

u = -0.34;
{kb2calc, kb8calc} = {Sqrt[rho1] 10^u, Sqrt[rho1] 10^-u}
{kb2calc kb8calc == rho1, kb2calc/kbRef[[2]], kb8calc/kbRef[[8]]}


(* ::Section:: *)
(*6. All four PdP cycles (Supplementary Table 5)*)

(* ::Text:: *)
(*The four cycles, each listed as {a, b, c, d} = {kinase binding, kinase catalysis, phosphatase binding, phosphatase catalysis}.*)

cycles = {{1, 2, 7, 8}, {3, 4, 5, 6}, {9, 10, 15, 16}, {11, 12, 13, 14}};


(* ::Text:: *)
(*For each cycle: the six given constants, rho from lnGamma = 19.8, the two rebinding constants with u = -0.34, and the checks lnKkin, lnKp, lnGamma and DeltaGc recomputed from all eight constants. Every cycle gives lnGamma = 19.800 and DeltaGc = 51.06 kJ/mol.*)

row[{a_, b_, c_, d_}] := Module[{rh, kbb, kbd},
  rh = kfRef[[a]] kfRef[[b]] kfRef[[c]] kfRef[[d]]/(kbRef[[a]] kbRef[[c]] Exp[19.8]);
  kbb = Sqrt[rh] 10^-0.34; kbd = Sqrt[rh] 10^0.34;
  {StringJoin["R", ToString[a], ",R", ToString[b], "|R", ToString[c], ",R", ToString[d]],
   kfRef[[a]], kbRef[[a]], kfRef[[b]], kfRef[[c]], kbRef[[c]], kfRef[[d]], ScientificForm[rh, 4], ScientificForm[kbb, 4], ScientificForm[kbd, 4],
   NumberForm[Log[kfRef[[a]] kfRef[[b]]/(kbRef[[a]] kbb)], {6, 3}], NumberForm[Log[kfRef[[c]] kfRef[[d]]/(kbRef[[c]] kbd)], {6, 3}],
   NumberForm[Log[kfRef[[a]] kfRef[[b]] kfRef[[c]] kfRef[[d]]/(kbRef[[a]] kbb kbRef[[c]] kbd)], {6, 3}],
   NumberForm[RT Log[kfRef[[a]] kfRef[[b]] kfRef[[c]] kfRef[[d]]/(kbRef[[a]] kbb kbRef[[c]] kbd)], {5, 2}]}]


TableForm[row /@ cycles, TableHeadings -> {None, {"cycle", "kfa", "kba", "kfb", "kfc", "kbc", "kfd", "rho", "kbb", "kbd", "lnKkin", "lnKp", "lnGamma", "DeltaGc"}}]


(* ::Text:: *)
(*Check against the constants used in the simulations (Table 3): the ratio computed/used is 1 for all eight rebinding constants.*)

Table[With[{rh = kfRef[[c[[1]]]] kfRef[[c[[2]]]] kfRef[[c[[3]]]] kfRef[[c[[4]]]]/(kbRef[[c[[1]]]] kbRef[[c[[3]]]] Exp[19.8])},
  {Sqrt[rh] 10^-0.34/kbRef[[c[[2]]]], Sqrt[rh] 10^0.34/kbRef[[c[[4]]]]}], {c, cycles}]


(* ::Section:: *)
(*7. The scaffold loop (Methods 4.2, Step 6; Eq 2; Supplementary Table 7)*)

(* ::Text:: *)
(*eIF4F forms by two routes: R18 then R19 (e4E + e4G -> e4GE, e4GE + e4A -> e4F) or R20 then R21 (e4G + e4A -> e4GA, e4GA + e4E -> e4F). No ATP is used, so both routes must have the same overall equilibrium constant (Wegscheider condition, Gamma = 1): 1/(KD18 KD19) = 1/(KD20 KD21). Solving for KD21 gives Eq (2).*)

Solve[1/(KD18 KD19) == 1/(KD20 KD21), KD21]


(* ::Text:: *)
(*Numbers: KD = kb/kf for these binding reactions; KD18 = 27, KD19 = 230, KD20 = 56 nM give KD21 = 110.9 nM and kb21 = KD21 kf21.*)

{KD18n, KD19n, KD20n} = Table[kbRef[[i]]/kfRef[[i]], {i, 18, 20}]
KD21n = KD18n KD19n/KD20n
kb21n = KD21n kfRef[[21]]
{kb21n/kbRef[[21]], KD20n KD21n/(KD18n KD19n)}


(* ::Section:: *)
(*8. Driving strength in kJ/mol (Results 2.6)*)

(* ::Text:: *)
(*The network becomes bistable at lnGamma = 4.9 and tristable at lnGamma = 10.8 (Results 2.6, computed by MATLAB M06). Converted to free energy: 12.6 and 27.8 kJ/mol. The reference lnGamma = 19.8 is about 9 RT above the minimum for tristability, and 19.8/10.8 = 1.8 times it.*)

{4.9 RT, 10.8 RT, 19.8 - 10.8, 19.8/10.8}


(* ::Section:: *)
(*9. Stoichiometric matrix of R1-R22 (Supplementary Note 3)*)

(* ::Text:: *)
(*Species, in the order of the MATLAB code (p4e_ssa_tables): kin, P, e4E, BP, e4G, e4A, S0 (BPe4E), S1, S2, S3, S4, BPp4, C1-C8, e4GE, e4GA, e4F. Each reaction is {reactants, products} as species numbers.*)

species = {"kin", "P", "e4E", "BP", "e4G", "e4A", "S0", "S1", "S2", "S3", "S4", "BPp4", "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "e4GE", "e4GA", "e4F"};
rx = {{{7, 1}, {13}}, {{13}, {8, 1}}, {{8, 1}, {14}}, {{14}, {9, 1}}, {{9, 2}, {15}}, {{15}, {8, 2}}, {{8, 2}, {16}}, {{16}, {7, 2}},
  {{9, 1}, {17}}, {{17}, {10, 1}}, {{10, 1}, {18}}, {{18}, {11, 1}}, {{11, 2}, {19}}, {{19}, {10, 2}}, {{10, 2}, {20}}, {{20}, {9, 2}},
  {{11}, {3, 12}}, {{3, 5}, {21}}, {{21, 6}, {23}}, {{5, 6}, {22}}, {{22, 3}, {23}}, {{4, 3}, {7}}};
Length[rx]


(* ::Text:: *)
(*Stoichiometric matrix S: one row per reaction, one column per species; -1 for a reactant, +1 for a product.*)

S = Table[Table[Count[rx[[j, 2]], s] - Count[rx[[j, 1]], s], {s, 23}], {j, 22}];
{Dimensions[S], MatrixRank[S]}


(* ::Text:: *)
(*Rank 17: 23 - 17 = 6 conservation relations (total kinase, phosphatase, eIF4E, 4E-BP, eIF4G, eIF4A) and 22 - 17 = 5 independent loops.*)

{23 - MatrixRank[S], 22 - MatrixRank[S]}


(* ::Section:: *)
(*10. Loops by row reduction of [S | I] (Stanbury and Hoffman; Supplementary Note 3, Supplementary Fig 9A)*)

(* ::Text:: *)
(*Append the 22 x 22 identity matrix to S and row-reduce. Rows whose S-part (first 23 columns) is zero give, in the identity part, a loop: a combination of reactions with no net change of any species.*)

rr = RowReduce[Join[S, IdentityMatrix[22], 2]];
loops = Select[rr, AllTrue[#[[1 ;; 23]], # == 0 &] &][[All, 24 ;;]];
Dimensions[loops]


(* ::Text:: *)
(*Write each loop as a list of signed reactions. The five loops are the four PdP cycles L1-L4 and the scaffold loop L5.*)

loopText[v_] := StringRiffle[Table[If[v[[j]] > 0, "+R", "-R"] <> ToString[j], {j, Flatten[Position[v, x_ /; x != 0]]}], " "];
loopsN = Map[If[First[Select[#, # != 0 &]] < 0, -#, #] &, loops];
loopText /@ loopsN


(* ::Text:: *)
(*Check: S^T applied to each loop is zero (no species changes).*)

Max[Abs[loopsN . S]]


(* ::Text:: *)
(*Every reaction of the model is reversible, including the catalytic steps: all 22 backward constants are positive and finite, so every loop has a finite cycle ratio Gamma (Supplementary Note 3).*)

{AllTrue[kbRef, # > 0 &], Min[kbRef]}


(* ::Section:: *)
(*11. ATP, ADP and Pi explicit; Gamma of every loop; deficiency (Supplementary Note 3; Supplementary Figs 9B, 11; Supplementary Table 8)*)

(* ::Text:: *)
(*Add three species, ATP (24), ADP (25) and Pi (26): ATP consumed and ADP released in the kinase catalytic steps R2, R4, R10, R12; Pi released in the phosphatase catalytic steps R6, R8, R14, R16. The rank rises to 18 and four loops remain; none hydrolyses net ATP.*)

S2 = Map[Join[#, {0, 0, 0}] &, S];
Do[S2[[j, 24]] = -1; S2[[j, 25]] = 1, {j, {2, 4, 10, 12}}];
Do[S2[[j, 26]] = 1, {j, {6, 8, 14, 16}}];
rrF = RowReduce[Join[S2, IdentityMatrix[22], 2]];
loopsF = Select[rrF, AllTrue[#[[1 ;; 26]], # == 0 &] &][[All, 27 ;;]];
loopsF = Map[If[First[Select[#, # != 0 &]] < 0, -#, #] &, loopsF];
{MatrixRank[S2], loopText /@ loopsF}


(* ::Text:: *)
(*Gamma of a loop with coefficients nu: lnGamma = Sum nu_j Log[kf_j/kb_j]. With the reference constants, the four PdP cycles carry lnGamma = 19.8 (one ATP per turn) and every ATP-free loop has lnGamma = 0, as thermodynamics requires (Wegscheider condition). That the ATP-free loops F1-F3 combine one PdP cycle forward with cycle 4 backward is why all four cycles must share one value of Gamma.*)

lnK = Log[kfRef/kbRef];
{Chop[loopsN . lnK, 10^-9], Chop[loopsF . lnK, 10^-9]}


(* ::Text:: *)
(*Chemical reaction network theory: complexes (the distinct left- and right-hand sides), linkage classes (connected components of the reaction graph) and deficiency = complexes - linkage classes - rank = 5, equal to the number of loops; the number of circuit conditions is p - (n - l) = 0.*)

cx = DeleteDuplicates[Flatten[Map[{Sort[#[[1]]], Sort[#[[2]]]} &, rx], 1]];
g = Graph[Range[Length[cx]], Map[UndirectedEdge[Position[cx, Sort[#[[1]]]][[1, 1]], Position[cx, Sort[#[[2]]]][[1, 1]]] &, rx]];
{nC, nL} = {Length[cx], Length[ConnectedComponents[g]]};
{nC, nL, MatrixRank[S], nC - nL - MatrixRank[S], 22 - (nC - nL)}


(* ::Section:: *)
(*12. The split parameter u (Supplementary Note 2, Steps 9-14; Supplementary Table 6; Methods 4.2)*)

(* ::Text:: *)
(*Step 9. With the ATP drive Gamma and the six given constants fixed, Eq (1) (= Eq S2) contains the two rebinding constants kbb and kbd only through their product rho = kbb kbd (Eq S3). Here it is solved symbolically for kbb: the solution depends on kbd, so thermodynamics fixes only the product.*)

eqS2 = gam == kfa kfb kfc kfd/(kba kbb kbc kbd);
Solve[eqS2, kbb]
rhoS3 = kfa kfb kfc kfd/(kba kbc gam)


(* ::Text:: *)
(*Step 10. Definition of u (Eq S4): kbb = Sqrt[rho] 10^u, kbd = Sqrt[rho] 10^-u. The inverse (Eq S5) recovers rho and u from any positive pair, and the ratio kbb/kbd = 10^(2u) depends on u alone (Eq S6). The last line checks the inverse numerically for random rho and u.*)

kbbU = Sqrt[rh] 10^uu; kbdU = Sqrt[rh] 10^-uu;
Simplify[{kbbU kbdU, kbbU/kbdU}, rh > 0]
With[{r0 = RandomReal[{10^-16, 10^-8}], u0 = RandomReal[{-3, 3}]}, {kbbU kbdU/r0, Log10[kbbU/kbdU]/2 - u0} /. {rh -> r0, uu -> u0}]


(* ::Text:: *)
(*Step 11. Eq (1) holds exactly for every u (Eqs S7, S8): inserting Eq S4 and rho from Eq S3 gives back gam, with no u left.*)

Simplify[kfa kfb kfc kfd/(kba kbc kbbU kbdU) /. rh -> rhoS3, {kfa > 0, kfb > 0, kfc > 0, kfd > 0, kba > 0, kbc > 0, gam > 0}]


(* ::Text:: *)
(*Step 12. How u shares the drive between the two half-cycles (Eqs S9-S11). lnKkin = lnKkin0 - u Log[10] and lnKP = lnKP0 + u Log[10]; their sum is lnGamma for every u. Each unit of u moves RT Log[10] = 5.94 kJ/mol between the half-cycles; the +-0.3 of the local ensembles moves 1.78 kJ/mol.*)

lnKkinU = Log[kfa kfb/(kba kbbU)]; lnKPU = Log[kfc kfd/(kbc kbdU)];
Simplify[PowerExpand[{lnKkinU - (Log[kfa kfb/(kba Sqrt[rh])] - uu Log[10]), lnKPU - (Log[kfc kfd/(kbc Sqrt[rh])] + uu Log[10])}]]
Simplify[PowerExpand[lnKkinU + lnKPU /. rh -> rhoS3]]
Chop[{lnKkinU - (Log[kfa kfb/(kba Sqrt[rh])] - uu Log[10]), lnKPU - (Log[kfc kfd/(kbc Sqrt[rh])] + uu Log[10]), (lnKkinU + lnKPU /. rh -> rhoS3) - Log[gam]} /. Thread[{kfa, kfb, kfc, kfd, kba, kbc, gam, rh, uu} -> Join[RandomReal[{0.1, 10}, 8], {RandomReal[{-2, 2}]}]], 10^-9]
{RT Log[10], 0.3 RT Log[10]}


(* ::Text:: *)
(*Supplementary Table 6, all four cycles at the reference set (lnGamma = 19.8, u = -0.34): Sqrt[rho]; kbb/kbd = 10^(2u); lnKkin0 and lnKP0 (u = 0); lnKkin and lnKP (u = -0.34); the half-cycle shares RT lnK in kJ/mol (they add up to 51.06); the largest admissible |u| = Log10[0.1/Sqrt[rho]] (Eq S13, diffusion limit 0.1 1/(nM s)); the coefficients a, c, d, b of Eq S14; and the window of K/P inside which rebinding changes S(j+1)/S(j) by less than 1% (Eq S15), with its width in orders of magnitude (4.60 for every cycle). For cycle 1 the shares are 27.64 and 23.42 kJ/mol.*)

uRow[{ia_, ib_, ic_, id_}] := Module[{rh0, kbb0, kbd0, l0k, l0p, aj, cj, dj, bj},
  rh0 = kfRef[[ia]] kfRef[[ib]] kfRef[[ic]] kfRef[[id]]/(kbRef[[ia]] kbRef[[ic]] Exp[19.8]);
  kbb0 = Sqrt[rh0] 10^-0.34; kbd0 = Sqrt[rh0] 10^0.34;
  l0k = Log[kfRef[[ia]] kfRef[[ib]]/(kbRef[[ia]] Sqrt[rh0])]; l0p = Log[kfRef[[ic]] kfRef[[id]]/(kbRef[[ic]] Sqrt[rh0])];
  aj = kfRef[[ia]] kfRef[[ib]]/(kbRef[[ia]] + kfRef[[ib]]); cj = kbRef[[ia]] kbb0/(kbRef[[ia]] + kfRef[[ib]]);
  dj = kfRef[[ic]] kfRef[[id]]/(kbRef[[ic]] + kfRef[[id]]); bj = kbRef[[ic]] kbd0/(kbRef[[ic]] + kfRef[[id]]);
  {ScientificForm[Sqrt[rh0], 4], NumberForm[kbb0/kbd0, 4], NumberForm[{l0k, l0p}, {5, 3}], NumberForm[{l0k + 0.34 Log[10], l0p - 0.34 Log[10]}, {5, 3}],
   NumberForm[RT {l0k + 0.34 Log[10], l0p - 0.34 Log[10]}, {4, 2}], NumberForm[Log10[0.1/Sqrt[rh0]], {3, 2}],
   ScientificForm[{aj, cj, dj, bj}, 3], ScientificForm[{100 bj/aj, dj/(100 cj)}, 2], NumberForm[Log10[(dj/(100 cj))/(100 bj/aj)], {3, 2}]}]


TableForm[Transpose[uRow /@ cycles], TableHeadings -> {{"Sqrt[rho]", "kbb/kbd", "lnKkin0, lnKP0", "lnKkin, lnKP", "RT lnK (kJ/mol)", "max |u|", "a, c, d, b", "K/P window", "window width (decades)"}, {"cycle 1", "cycle 2", "cycle 3", "cycle 4"}}]


(* ::Text:: *)
(*Step 13. What u means chemically (Eq S12): with the nucleotides explicit, kbb = k'bb [ADP] and kbd = k'bd [Pi], so u = (1/2) Log10[k'bb/k'bd] + (1/2) Log10[ADP/Pi]. With free ADP = 0.1 mM and Pi = 10 mM the second term is -1, and u = -0.34 corresponds to k'bb/k'bd = 10^1.32 = 21.*)

Simplify[PowerExpand[Log10[(kpbb adp)/(kpbd pi)]/2 - (Log10[kpbb/kpbd]/2 + Log10[adp/pi]/2)]]
Chop[Log10[(kpbb adp)/(kpbd pi)]/2 - (Log10[kpbb/kpbd]/2 + Log10[adp/pi]/2) /. Thread[{kpbb, kpbd, adp, pi} -> RandomReal[{0.1, 10}, 4]], 10^-12]
{Log10[0.1/10]/2, 10^(2 (-0.34 + 1))}


(* ::Text:: *)
(*Step 14, when u matters. The width of the K/P window is proportional to 1/rho and therefore to Gamma. Lowering lnGamma from 19.8 narrows it by (19.8 - lnGamma)/Log[10] decades: about 0.7 decades at lnGamma = 10.8 (where tristability appears) and closed (negative width) at lnGamma = 4.9 (where bistability appears).*)

{4.60 - (19.8 - 10.8)/Log[10], 4.60 - (19.8 - 4.9)/Log[10], Exp[19.8 - 10.8], Exp[19.8 - 4.9]}


(* ::Text:: *)
(*End of the notebook. Every number printed above is quoted in the manuscript or its Supplementary Information at the place named in the section title.*)
