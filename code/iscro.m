function ans = iscro(P1,P2,Q1,Q2)   %判断两线段是否相交
P1Q1 = Q1 - P1; P1P2 = P2 - P1; P1Q2 = Q2 - P1;
P1Q1(:,3) = 0; P1P2(:,3) = 0; P1Q2(:,3) = 0;
a1 = cross(P1Q1,P1P2);a2 = cross(P1Q2,P1P2);
ans = -1 * min(sign(sign(dot(a1,a2))-1),0);
end