function [J1,J2,J3,J4,J5,A] = transform(J1,J2,J3,J4,J5,F,R6)

% E1 = [0 0 0;0 0 0;0 0 1];
% I1 = [28.015 -51.194 0.001;-51.194 467.695 0;0.001 0 482.453];
% I2 = [1358.527 33.961 514.457;33.961 3790.657 -44.331;514.457 -44.331 2821.845];
% I3 = [1687.955 -13.033 0;-13.033 1842.801 0;0 0 463.905];
% I4 = [1355.970 34.846 504.981;34.846 3788.712 -44.533;504.981 -44.533 2824.752];
% I5 = [28.015 51.194 0.001;51.194 467.695 0;0.001 0 482.453];

w1_1 = J1.d_angle;
w2_2 = rotate(J2.angle,1)*w1_1+J2.d_angle;
w3_3 = rotate(J3.angle,1)*w2_2+J3.d_angle;
w4_4 = rotate(J4.angle,1)*w3_3;%+J4.d_angle;
w5_5 = rotate(J5.angle,1)*w4_4;%+J5.d_angle;
w6_6 = rotate([0;0;pi],1)*w5_5;
% w2_2 = -J5.d_angle;
% w3_3 = -J4.d_angle;
% w4_4 = -J3.d_angle;
% w5_5 = -J2.d_angle;


J2.I(1,3) = -J2.I(1,3);
J2.I(2,3) = -J2.I(2,3);
J2.I(3,1) = -J2.I(3,1);

J4.I(1,3) = -J4.I(1,3);
J4.I(2,3) = -J4.I(2,3);
J4.I(3,1) = -J4.I(3,1);


% angle1 = J1.angle;
angle2 = J2.angle;
angle3 = J3.angle;
angle4 = J4.angle;
angle5 = J5.angle;

J1.angle(1) = atan(R6(3,2)/R6(2,2));
J1.angle(2) = atan(R6(1,3)/R6(1,1));
J1.angle(3) = asin(-R6(1,2));

J2.angle = -angle5;
J3.angle = [0;0;-pi]-angle4;
J4.angle = [0;0;-pi]-angle3;
J5.angle = -angle2;

J1.d_angle = zeros(3,1);
J2.d_angle = zeros(3,1);
J3.d_angle = zeros(3,1);
J4.d_angle = zeros(3,1);
J5.d_angle = zeros(3,1);

J1.d_angle = w6_6;
% J2.d_angle = w2_2;
% J3.d_angle = w3_3;
% J4.d_angle = w4_4;
% J5.d_angle = w5_5;

J2.Pc = [1 0 0;0 1 0;0 0 -1]*J2.Pc;
J3.Pc = [1 0 0;0 1 0;0 0 -1]*J3.Pc;
J4.Pc = [1 0 0;0 1 0;0 0 -1]*J4.Pc;

A = F;
