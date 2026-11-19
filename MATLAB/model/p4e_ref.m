function P = p4e_ref()
%P4E_REF  Reference (tristable) parameter set of the manuscript (Table 3).
%   P.kf(i), P.kb(i), i = 1..22 (units nM, s^-1, nM^-1 s^-1); P.tot = [e4E_T BP_T P_T e4G_T e4A_T] (nM).
%   R1-R16: PdP ladder (binding / catalysis), R17: release of BPp4 from eIF4E (K_D17 = kf17/kb17),
%   R18-R21: scaffold (eIF4E:eIF4G, eIF4GE:eIF4A, eIF4G:eIF4A, eIF4GA:eIF4E), R22: 4E-BP:eIF4E binding.
P.kf = [0.031 0.0029 0.1 17.0 0.023 0.027 0.03 0.14 0.1 0.002 0.013 30.0 0.02 0.24 0.012 0.15 10.0 0.095 0.061 0.076 0.0065 0.1];
P.kb = [0.11 1.8118049126429878e-08 0.032 5.248190926288552e-06 0.63 2.5119421075763224e-05 5.5 8.671843526089229e-08 ...
        0.42 1.2059530144173232e-08 1.2 7.161218699078797e-06 0.016 3.427574767082689e-05 3.1 5.772054026273275e-08 ...
        0.0020408163265306124 2.565 14.03 4.256 0.7208035714285713 0.5];
P.tot = [1000 4500 41 300 2000];
P.links = [1 2 7 8; 3 4 5 6; 9 10 15 16; 11 12 13 14];   % (kin binding, kin catalysis, phos binding, phos catalysis) per link
end
