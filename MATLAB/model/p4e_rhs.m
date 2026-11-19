function d = p4e_rhs(y, P, kinT)
%P4E_RHS  Full mass-action ODEs R1-R22 (17 states, same order as TrannslationPIC.m).
kf = P.kf; kb = P.kb; tot = P.tot; k = y(:)';
e4A = tot(5) - (k(1) + k(16)); e4G = tot(4) - (k(1) + k(16) + k(15));
Pp = tot(3) - (k(7) + k(8) + k(12) + k(13)); kin = kinT - (k(4) + k(6) + k(9) + k(11));
e4E = tot(1) - (k(17)+k(5)+k(10)+k(3)+k(2)+k(4)+k(6)+k(7)+k(8)+k(9)+k(11)+k(12)+k(13)+k(1)+k(15));
BP = tot(2) - (k(17)+k(5)+k(10)+k(3)+k(2)+k(14)+k(4)+k(6)+k(7)+k(8)+k(9)+k(11)+k(12)+k(13));
r = zeros(1, 22);
r(1) = kf(1)*k(17)*kin - kb(1)*k(4);  r(2) = kf(2)*k(4) - kb(2)*k(5)*kin;
r(3) = kf(3)*k(5)*kin - kb(3)*k(6);   r(4) = kf(4)*k(6) - kb(4)*k(2)*kin;
r(5) = kf(5)*k(2)*Pp - kb(5)*k(7);    r(6) = kf(6)*k(7) - kb(6)*k(5)*Pp;
r(7) = kf(7)*k(5)*Pp - kb(7)*k(8);    r(8) = kf(8)*k(8) - kb(8)*k(17)*Pp;
r(9) = kf(9)*k(2)*kin - kb(9)*k(9);   r(10) = kf(10)*k(9) - kb(10)*k(10)*kin;
r(11) = kf(11)*k(10)*kin - kb(11)*k(11); r(12) = kf(12)*k(11) - kb(12)*k(3)*kin;
r(13) = kf(13)*k(3)*Pp - kb(13)*k(12); r(14) = kf(14)*k(12) - kb(14)*k(10)*Pp;
r(15) = kf(15)*k(10)*Pp - kb(15)*k(13); r(16) = kf(16)*k(13) - kb(16)*k(2)*Pp;
r(17) = kf(17)*k(3) - kb(17)*e4E*k(14);
r(18) = kf(18)*e4E*e4G - kb(18)*k(15); r(19) = kf(19)*k(15)*e4A - kb(19)*k(1);
r(20) = kf(20)*e4G*e4A - kb(20)*k(16); r(21) = kf(21)*k(16)*e4E - kb(21)*k(1);
r(22) = kf(22)*BP*e4E - kb(22)*k(17);
d = [r(19)+r(21); r(4)-r(5)-r(9)+r(16); r(12)-r(13)-r(17); r(1)-r(2); r(2)-r(3)+r(6)-r(7); r(3)-r(4); ...
     r(5)-r(6); r(7)-r(8); r(9)-r(10); r(10)-r(11)+r(14)-r(15); r(11)-r(12); r(13)-r(14); r(15)-r(16); ...
     r(17); r(18)-r(19); r(20)-r(21); -r(1)+r(8)+r(22)];
end
