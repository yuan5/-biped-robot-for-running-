function [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10] = paint_model(A,J1,J2,J3,J4,J5,l1,l2,P3_4,l4,l5)

color1 = 'b';
color2 = 'r';
R1 = rotate(J1.angle,0);
B = R1*[l5;0;0]+A;
R2 = R1*rotate(J2.angle,0);
C = R2*[l4;0;0]+B;
R3 = R2*rotate(J3.angle,0);
D = R3*P3_4+C;
R4 = R3*rotate(J4.angle,0);
E = R4*[l2;0;0]+D;
R5 = R4*rotate(J5.angle,0);
F = R5*[l1;0;0]+E;

p1 = paint_line(A,B,color1);
p2 = paint_line(B,C,color1);
p3 = paint_line(C,D,color1);
p4 = paint_line(D,E,color1);
p5 = paint_line(E,F,color1);

p6 = paint_line(R1*[J1.Pc(1);0;0]+A,R1*J1.Pc+A,color2);
p7 = paint_line(R2*[J2.Pc(1);0;0]+B,R2*J2.Pc+B,color2);
p8 = paint_line(R3*[0;0;J3.Pc(3)]+C,R3*J3.Pc+C,color2);
p9 = paint_line(R4*[J4.Pc(1);0;0]+D,R4*J4.Pc+D,color2);
p10 = paint_line(R5*[J5.Pc(1);0;0]+E,R5*J5.Pc+E,color2);
