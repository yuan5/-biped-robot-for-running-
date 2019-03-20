function [R] = Mart_vec(V)
R = zeros(3,3);
R(1,2) = V(3);
R(1,3) = -V(2);
R(2,1) = -V(3);
R(2,3) = V(1);
R(3,1) = V(2);
R(3,2) = -V(1);
