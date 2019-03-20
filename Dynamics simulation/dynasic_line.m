function [dd_angle1,dd_angle2,dd_angle3,dd_angle4,dd_angle5,N3_3] = dynasic_line(l1,l2,l3,l4,l5,Pi_,t)
    
    Z = [0;0;1];
    M = zeros(15,15);
    M_ = zeros(7,7);
    Q = zeros(15,1);
    Q_ = zeros(7,1);
    
    angle1(1:3,1) = l1.angle;
    angle2(1:3,1) = l2.angle;
    angle3(1:3,1) = l3.angle;
    angle4(1:3,1) = l4.angle;
    angle5(1:3,1) = l5.angle;
    
    d_angle1(1:3,1) = l1.d_angle;
    d_angle2(1:3,1) = l2.d_angle;
    d_angle3(1:3,1) = l3.d_angle;
    d_angle4(1:3,1) = l4.d_angle;
    d_angle5(1:3,1) = l5.d_angle;
    
    Pc1_1(1:3,1) = l1.Pc;
    Pc2_2(1:3,1) = l2.Pc;
    Pc3_3(1:3,1) = l3.Pc;
    Pc4_4(1:3,1) = l4.Pc;
    Pc5_5(1:3,1) = l5.Pc;
    
    P1_2(1:3,1) = Pi_(1:3);
    P2_3(1:3,1) = Pi_(4:6);
    P3_4(1:3,1) = Pi_(7:9);
    P4_5(1:3,1) = Pi_(10:12);
    
    m1 = l1.m;
    m2 = l2.m;
    m3 = l3.m;
    m4 = l4.m;
    m5 = l5.m;
    
    I1(1:3,1:3) = l1.I/10^6;
    I2(1:3,1:3) = l2.I/10^6;
    I3(1:3,1:3) = l3.I/10^6;
    I4(1:3,1:3) = l4.I/10^6;
    I5(1:3,1:3) = l5.I/10^6;
    
    g = 9.8;
   E1 = [1 0 0;0 1 0;0 0 0];
%    E2 = [0 0 0;0 0 0;0 0 1];
   w1_1 = d_angle1;
%    d_angle2
   w2_2 = rotate(angle2,1)*w1_1+d_angle2;
   w3_3 = rotate(angle3,1)*w2_2+d_angle3;
   w4_4 = rotate(angle4,1)*w3_3+d_angle4;
   w5_5 = rotate(angle5,1)*w4_4+d_angle5;
   v1_1 = rotate(angle1,1)*[0;g;0];
   
   K = rotate(angle2,1);
   Mk1 = K*Mart_vec(P1_2);
   Qk1 = K*(cross(w1_1,cross(w1_1,P1_2))+v1_1);
   
   K = rotate(angle3,1);
   Mk2 = K*Mk1;
   Mk3 = K*Mart_vec(P2_3);
   Qk2 = K*(cross(w2_2,cross(w2_2,P2_3))+Qk1);
   
   K = rotate(angle4,1);
   Mk4 = K*Mk2;
   Mk5 = K*Mk3;
   Mk6 = K*Mart_vec(P3_4);
   Qk3 = K*(cross(w3_3,cross(w3_3,P3_4))+Qk2);
   
   K = rotate(angle5,1);
   Mk7 = K*Mk4;
   Mk8 = K*Mk5;
   Mk9 = K*Mk6;
   Mk10 = K*Mart_vec(P4_5);
   Qk4 = K*(cross(w4_4,cross(w4_4,P4_5))+Qk3);
   
   Mk11 = Mart_vec(Pc5_5);
   Qk5 = cross(w5_5,cross(w5_5,Pc5_5))+Qk4;
   
   K = m5*Mart_vec(Pc5_5);
   Mk12 = K*Mk7;
   Mk13 = K*Mk8;
   Mk14 = K*Mk9;
   Mk15 = K*Mk10;
   Mk16 = K*Mk11;
   Qk6 = K*Qk5;
   
   M1 = Mk12;
   M2 = Mk13;
   M3 = Mk14;
   M4 = Mk15;
   M5 = Mk16-I5;
   Q1 = cross(w5_5,I5*w5_5)-t(5)*Z-Qk6;
   
   %second 
   Mk17 = -E1*Mk12;
   Mk18 = -E1*Mk13;
   Mk19 = -E1*Mk14;
   Mk20 = -E1*Mk15;
   Mk21 = -E1*Mk16;
   Qk7 = -E1*Qk6 - t(5)*Z;
   
   Mk22 = m4*Mk4;
   Mk23 = m4*Mk5;
   Mk24 = m4*Mk6;
   Mk25 = m4*Mart_vec(Pc4_4);
   Qk8 = m4*(cross(w4_4,cross(w4_4,Pc4_4))+Qk3);
   
   K = rotate(angle5,0);
   K1 = Mart_vec(Pc4_4);
   K2 = m5*Mart_vec(P4_5)*K;
   Mk26 = -K*Mk17+K1*Mk22+K2*Mk7;
   Mk27 = -K*Mk18+K1*Mk23+K2*Mk8;
   Mk28 = -K*Mk19+K1*Mk24+K2*Mk9;
   Mk29 = -K*Mk20+K1*Mk25+K2*Mk10;
   Mk30 = -K*Mk21+K2*Mk11;
   Qk9 = t(4)*Z-K*Qk7+K1*Qk8+K2*Qk5;
   
   M6 = Mk26;
   M7 = Mk27;
   M8 = Mk28;
   M9 = Mk29-I4;
   M10 = Mk30;
   Q2 = cross(w4_4,I4*w4_4)-Qk9;
   
   %third
   K = rotate(angle5,0)*m5;
   Mk31 = K*Mk7+Mk22;
   Mk32 = K*Mk8+Mk23;
   Mk33 = K*Mk9+Mk24;
   Mk34 = K*Mk10+Mk25;
   Mk35 = K*Mk11;
   Qk10 = K*Qk5+Qk8;
   
   Mk36 = m5*Mk7;
   Mk37 = m5*Mk8;
   Mk38 = m5*Mk9;
   Mk39 = m5*Mk10;
   Mk40 = m5*Mk11;
   Qk11 = m5*Qk5;
   
   K = rotate(angle5,0);
   K1 = Mart_vec(Pc4_4);
   K2 = Mart_vec(P4_5)*K;
   Mk41 = K*Mk17-E1*(K1*Mk22+K2*Mk36);
   Mk42 = K*Mk18-E1*(K1*Mk23+K2*Mk37);
   Mk43 = K*Mk19-E1*(K1*Mk24+K2*Mk38);
   Mk44 = K*Mk20-E1*(K1*Mk25+K2*Mk39);
   Mk45 = K*Mk21-E1*K2*Mk40;
   Qk12 = K*Qk7-E1*(K1*Qk8+K2*Qk11)-t(4)*Z;
   
   Mk46 = m3*Mk2;
   Mk47 = m3*Mk3;
   Mk48 = m3*Mart_vec(Pc3_3);
   Qk13 = m3*(cross(w3_3,cross(w3_3,Pc3_3))+Qk2);
   
   K = rotate(angle4,0);
   K1 = Mart_vec(Pc3_3);
   K2 = Mart_vec(P3_4)*K;
   Mk49 = -K*Mk41+K1*Mk46+K2*Mk31;
   Mk50 = -K*Mk42+K1*Mk47+K2*Mk32;
   Mk51 = -K*Mk43+K1*Mk47+K2*Mk33;
   Mk52 = -K*Mk44+K2*Mk34;
   Mk53 = -K*Mk45+K2*Mk35;
   Qk14 = t(3)*Z-K*Qk12+K1*Qk13+K2*Qk10;
   
   M11 = Mk49;
   M12 = Mk50;
   M13 = Mk51-I3;
   M14 = Mk52;
   M15 = Mk53;
   Q3 = cross(w3_3,I3*w3_3)-Qk14;
   
   %fourth
   K = rotate(angle4,0);
   Mk54 = K*Mk31+Mk46;
   Mk55 = K*Mk32+Mk47;
   Mk56 = K*Mk33+Mk48;
   Mk57 = K*Mk34;
   Mk58 = K*Mk35;
   Qk15 = K*Qk10+Qk13;
   
   K1 = Mart_vec(Pc3_3);
   K2 = Mart_vec(P3_4)*K;
   Mk59 = K*Mk41-E1*(K1*Mk46+K2*Mk31);
   Mk60 = K*Mk42-E1*(K1*Mk47+K2*Mk32);
   Mk61 = K*Mk43-E1*(K1*Mk48+K2*Mk33);
   Mk62 = K*Mk44-E1*(K2*Mk34);
   Mk63 = K*Mk45-E1*(K2*Mk35);
   Qk16 = K*Qk12-E1*(K1*Qk13+K2*Qk10)+t(3)*Z;
   
   Mk64 = m2*Mk1;
   Mk65 = m2*Mart_vec(Pc2_2);
   Qk17 = m2*(cross(w2_2,cross(w2_2,Pc2_2))+Qk1);
   
   K = rotate(angle3,0);
   K1 = Mart_vec(Pc2_2);
   K2 = Mart_vec(P2_3)*K;
   Mk66 = -K*Mk59+K1*Mk64+K2*Mk54;
   Mk67 = -K*Mk60+K1*Mk65+K2*Mk55;
   Mk68 = -K*Mk61+K2*Mk56;
   Mk69 = -K*Mk62+K2*Mk57;
   Mk70 = -K*Mk63+K2*Mk58;
   %此处有问题，一定得改！！！
   Qk18 = t(2)*Z-K*Qk16+K1*Qk17+K2*Qk15;
   
   M16 = Mk66;
   M17 = Mk67-I2;
   M18 = Mk68;
   M19 = Mk69;
   M20 = Mk70;
   Q4 = cross(w2_2,I2*w2_2)-Qk18;
   
   K = rotate(angle3,0);
   Mk71 = K*Mk54+Mk64;
   Mk72 = K*Mk55+Mk65;
   Mk73 = K*Mk56;
   Mk74 = K*Mk57;
   Mk75 = K*Mk58;
   Qk19 = K*Qk15+Qk17;
   
   K = rotate(angle3,0);
   K1 = Mart_vec(Pc2_2);
   K2 = Mart_vec(P2_3)*K;
%    Mk76 = (K*Mk59-K1*Mk64-K2*Mk54);
%    Mk77 = (K*Mk60-K1*Mk65-K2*Mk55);
%    Mk78 = (K*Mk61-K2*Mk56);
%    Mk79 = (K*Mk62-K2*Mk57);
%    Mk80 = (K*Mk63-K2*Mk58);
%    Qk20 = (K*Qk16-K1*Qk17-K2*Qk15)+t(2)*Z;
   Mk76 = E1*(K*Mk59-K1*Mk64-K2*Mk54);
   Mk77 = E1*(K*Mk60-K1*Mk65-K2*Mk55);
   Mk78 = E1*(K*Mk61-K2*Mk56);
   Mk79 = E1*(K*Mk62-K2*Mk57);
   Mk80 = E1*(K*Mk63-K2*Mk58);
   Qk20 = E1*(K*Qk16-K1*Qk17-K2*Qk15)+t(2)*Z;
   
   Mk81 = m1*Mart_vec(Pc1_1);
   Qk21 = m1*(cross(w1_1,cross(w1_1,Pc1_1))+v1_1);
   
   K = rotate(angle2,0);
   K1 = Mart_vec(Pc1_1);
   K2 = Mart_vec(P1_2)*K;
   Mk82 = -K*Mk76+K1*Mk81+K2*Mk71;
   Mk83 = -K*Mk77+K2*Mk72;
   Mk84 = -K*Mk78+K2*Mk73;
   Mk85 = -K*Mk79+K2*Mk74;
   Mk86 = -K*Mk80+K2*Mk75;
   Qk22 = t(1)*Z-K*Qk20+K1*Qk21+K2*Qk19;
   
   M21 = Mk82-I1;
   M22 = Mk83;
   M23 = Mk84;
   M24 = Mk85;
   M25 = Mk86;
   Q5 = cross(w1_1,I1*w1_1)-Qk22;
   
   %未改动的
   E = [0 0 0;0 0 0;0 0 1];
   Mj1 = rotate(angle2,1);
   Qj1 = rotate(angle2,1)*cross(w1_1,E*d_angle2);
   Mj2 = rotate(angle3,1)*Mj1;
   Mj3 = rotate(angle3,1)*E;
   Qj2 = rotate(angle3,1)*cross(w2_2,E*d_angle3);
   Mj4 = rotate(angle4,1)*Mj2;
   Mj5 = rotate(angle4,1)*Mj3;
   Mj6 = rotate(angle4,1)*E;
   Qj3 = rotate(angle4,1)*cross(w3_3,E*d_angle4);
   Mj7 = rotate(angle5,1)*Mj4;
   Mj8 = rotate(angle5,1)*Mj5;
   Mj9 = rotate(angle5,1)*Mj6;
   Mj10 = rotate(angle5,1)*E;
   Qj4 = rotate(angle5,1)*cross(w4_4,E*d_angle5);
   
   
   M(1:3,1:3) = M1+M2*Mj1+M3*Mj2+M4*Mj4+M5*Mj7;
   M(1:3,4:6) = M2*E+M3*Mj3+M4*Mj5+M5*Mj8;
   M(1:3,7:9) = M3*E+M4*Mj6+M5*Mj9;
   M(1:3,10:12) = M4*E+M5*Mj10;
   M(1:3,13:15) = M5*E;
   
   M(4:6,1:3) = M6+M7*Mj1+M8*Mj2+M9*Mj4+M10*Mj7;
   M(4:6,4:6) = M7*E+M8*Mj3+M9*Mj5+M10*Mj8;
   M(4:6,7:9) = M8*E+M9*Mj6+M10*Mj9;
   M(4:6,10:12) = M9*E+M10*Mj10;
   M(4:6,13:15) = M10*E;
   
   M(7:9,1:3) = M11+M12*Mj1+M13*Mj2+M14*Mj4+M15*Mj7;
   M(7:9,4:6) = M12*E+M13*Mj3+M14*Mj5+M15*Mj8;
   M(7:9,7:9) = M13*E+M14*Mj6+M15*Mj9;
   M(7:9,10:12) = M14*E+M15*Mj10;
   M(7:9,13:15) = M15*E;
   
   M(10:12,1:3) = M16+M17*Mj1+M18*Mj2+M19*Mj4+M20*Mj7;
   M(10:12,4:6) = M17*E+M18*Mj3+M19*Mj5+M20*Mj8;
   M(10:12,7:9) = M18*E+M19*Mj6+M20*Mj9;
   M(10:12,10:12) = M19*E+M20*Mj10;
   M(10:12,13:15) = M20*E;
   
   M(13:15,1:3) = M21+M22*Mj1+M23*Mj2+M24*Mj4+M25*Mj7;
   M(13:15,4:6) = M22*E+M23*Mj3+M24*Mj5+M25*Mj8;
   M(13:15,7:9) = M23*E+M24*Mj5+M25*Mj9;
   M(13:15,10:12) = M24*E+M25*Mj10;
   M(13:15,13:15) = M25*E;
   
 
   M_(1,1:3) = M(3,1:3);
   M_(1,4) = M(3,6);
   M_(1,5) = M(3,9);
   M_(1,6) = M(3,12);
   M_(1,7) = M(3,15);
   
   M_(2,1:3) = M(6,1:3);
   M_(2,4) = M(6,6);
   M_(2,5) = M(6,9);
   M_(2,6) = M(6,12);
   M_(2,7) = M(6,15);
   
   M_(3,1:3) = M(9,1:3);
   M_(3,4) = M(9,6);
   M_(3,5) = M(9,9);
   M_(3,6) = M(9,12);
   M_(3,7) = M(9,15);
   
   M_(4,1:3) = M(12,1:3);
   M_(4,4) = M(12,6);
   M_(4,5) = M(12,9);
   M_(4,6) = M(12,12);
   M_(4,7) = M(12,15);
   
   M_(5:7,1:3) = M(13:15,1:3);
   M_(5:7,4) = M(13:15,6);
   M_(5:7,5) = M(13:15,9);
   M_(5:7,6) = M(13:15,12);
   M_(5:7,7) = M(13:15,15);
   
   Q(1:3) = Q1-M2*Qj1-M3*Qj2-M4*Qj3-M5*Qj4;
   Q(4:6) = Q2-M7*Qj1-M8*Qj2-M9*Qj3-M10*Qj4;
   Q(7:9) = Q3-M12*Qj1-M13*Qj2-M14*Qj3-M15*Qj4;
   Q(10:12) = Q4-M17*Qj1-M18*Qj2-M19*Qj3-M20*Qj4;
   Q(13:15) = Q5-M22*Qj1-M23*Qj2-M24*Qj3-M25*Qj4;

   Q_(1) = Q(3);
   Q_(2) = Q(6);
   Q_(3) = Q(9);
   Q_(4) = Q(12);
   Q_(5:7) = Q(13:15);
   
   d_w = M_\Q_;
   
   dd_angle1 = d_w(1:3);
   dd_angle2 = [0;0;d_w(4)];
   dd_angle3 = [0;0;d_w(5)];
   dd_angle4 = [0;0;d_w(6)];
   dd_angle5 = [0;0;d_w(7)];
   
%    dw1_1 = dd_angle1;
%    dw2_2 = rotate(angle2,1)*(dw1_1+cross(w1_1,l2.d_angle))+dd_angle2;
%    dw3_3 = rotate(angle3,1)*(dw2_2+cross(w2_2,l3.d_angle))+dd_angle3;
%    dw4_4 = rotate(angle4,1)*(dw3_3+cross(w3_3,l4.d_angle))+dd_angle4;
%    dw5_5 = rotate(angle5,1)*(dw4_4+cross(w4_4,l5.d_angle))+dd_angle5;
%    
%    N3_3(1:3,1) = Mk49*dw1_1+Mk50*dw2_2+Mk51*dw3_3+Mk52*dw4_4+Mk53*dw5_5+Qk14;
%    N3_3(4:6,1) = Mk53*dw5_5;
   
   
   