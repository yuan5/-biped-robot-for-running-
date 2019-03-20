clc
close all
clear all;

g = 9.8;
rad_deg = 180/pi;
deg_rad = pi/180;

dt= 0.001;
times = 900;
% times = 1;
max_angle = 119.4884*deg_rad;
min_angle = 60*deg_rad;
kt = 10;
X = [1;0;0];
Y = [0;1;0];
Z = [0;0;1];
E1 = [0 0 0;0 0 0;0 0 1 ];
A = [0;0;0];

Point_A = 1:3;
Point_B = 4:6;
Point_C = 7:9;
Point_D = 10:12;
Point_E = 13:15;
Point_F = 16:18;
% titude = [0;1;0];
% x = 1;
% y = 2;
% z = 3;

m1 = 0.118;
I1 = [28.015 -51.194 0.001;-51.194 467.695 0;0.001 0 482.453];
l1 = 221.7/1000;
Pc1_1 = [159.438;-7.042;0]/1000;
% angle1 = [-0.3684;0.0254;1.3688];
angle1 = [0;0;55]*deg_rad;
d_angle1 = zeros(3,1);
% d_angle1 = [1.5;0;0];
dd_angle1 = zeros(3,1);

m2 = 1.070;
I2 = [1355.982 34.749 -505.602;34.749 3788.472 44.510;-505.602 44.510 2824.409];
l2 = 203.25/1000;
Pc2_2 = [152.285;0.515;33.163]/1000;
P1_2 = [l1;0;0];
% angle2 = [0;0;1.4060];
angle2 = [0;0;100]*deg_rad;
d_angle2 = zeros(3,1);
dd_angle2 = zeros(3,1);

m3 = 0.426;
I3 = [1687.955 -13.033 0;-13.033 1842.801 0;0 0 463.905];
l3 = 178.77/1000;
lc3 = l3/2;
Pc3_3 = [26.283;-0.937;-89.386]/1000;
P2_3 = [l2;0;0];
% angle3 = [0;0;0.1553];
% angle3 = [0;0;-65]*deg_rad;
angle3 = -(angle1+angle2-[0;0;pi/2]);
d_angle3 = zeros(3,1);
dd_angle3 = zeros(3,1);

m4 = 1.070;
I4 = [1358.773 34.450 -511.172;34.450 3792.207 44.445;-511.172 44.445 2824.791];
l4 = 203.25/1000;
Pc4_4 = [50.935;-0.512;-33.118]/1000;
P3_4 = [0;0;-l3];
% angle4 = [0;0;-3.3489];
% angle4 = [0;0;-115]*deg_rad;
angle4 = [0;0;-pi]-angle3;
d_angle4 = zeros(3,1);
dd_angle4 = zeros(3,1);

m5 = 0.118;
I5 = [28.015 51.194 0.001;51.194 467.695 0;0.001 0 482.453];
l5 = 221.7/1000;
Pc5_5 = [62.274;7.042;0]/1000;
P4_5 = [l4;0;0];
angle5 = -angle2;
% angle5 = [0;0;-100]*deg_rad;
d_angle5 = zeros(3,1);
dd_angle5 = zeros(3,1);

R1 = rotate(angle1,0);
figure(1);
O = [0;0;0];
B = R1*P1_2+O;
color1 = 'b';
color2 = 'r';
p1 = paint_line(A,B,color1);
% axis([-0.1 0.3 0 0.6 -0.2 0.2]);
hold on;
grid on;
paint_line([0;0;0],[0.5;0;0],'r');
paint_line([0;0;0],[0;0.5;0],'b');
paint_line([0;0;0],[0;0;0.5],'k');
delete(p1);

R1 = rotate(angle1,0);
B = R1*[l5;0;0]+A;
R2 = R1*rotate(angle2,0);
C = R2*[l4;0;0]+B;
R3 = R2*rotate(angle3,0);
D = R3*P3_4+C;
R4 = R3*rotate(angle4,0);
E = R4*[l2;0;0]+D;
R5 = R4*rotate(angle5,0);
F = R5*[l1;0;0]+E;

% color1 = 'w';
% color2 = 'w';

paint_line(A,B,color1);
paint_line(B,C,color1);
paint_line(C,D,color1);
paint_line(D,E,color1);
paint_line(E,F,color1);

paint_line(R1*[Pc1_1(1);0;0]+A,R1*Pc1_1+A,color2);
paint_line(R2*[Pc2_2(1);0;0]+B,R2*Pc2_2+B,color2);
paint_line(R3*[0;0;Pc3_3(3)]+C,R3*Pc3_3+C,color2);
paint_line(R4*[Pc4_4(1);0;0]+D,R4*Pc4_4+D,color2);
paint_line(R5*[Pc5_5(1);0;0]+E,R5*Pc5_5+E,color2);

J1 = Joint(m1,I1,Pc1_1,angle1,d_angle1);
J2 = Joint(m2,I2,Pc2_2,angle2,d_angle2);
J3 = Joint(m3,I3,Pc3_3,angle3,d_angle3);
J4 = Joint(m4,I4,Pc4_4,angle4,d_angle4);
J5 = Joint(m5,I5,Pc5_5,angle5,d_angle5);

T = rotate(angle1,0)*rotate(angle2,0)*rotate(angle3,0);
   
t1 = zeros(1,times);
t2 = zeros(1,times);
t3 = zeros(1,times);
t4 = zeros(1,times);
t5 = zeros(1,times);

t1 = t1+0;

adj1 = 5;
adj2 = 15;

for i=1:1:adj1
    t5(i) = t5(i)-0.718;
end
for i=1:1:adj2
   t4(i) = t4(i)+1.2; 
end
t2 = t2-5.3;

Pi_ = zeros(12,1);
Pi_(1:3) = P1_2;
Pi_(4:6) = P2_3;
Pi_(7:9) = P3_4;
Pi_(10:12) = P4_5;

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

color1 = 'r';
color2 = 'r';
paint_line(A,B,color1);
paint_line(B,C,color1);
paint_line(C,D,color1);
paint_line(D,E,color1);
paint_line(E,F,color1);

paint_line(R1*[Pc1_1(1);0;0]+A,R1*Pc1_1+A,color2);
paint_line(R2*[Pc2_2(1);0;0]+B,R2*Pc2_2+B,color2);
paint_line(R3*[0;0;Pc3_3(3)]+C,R3*Pc3_3+C,color2);
paint_line(R4*[Pc4_4(1);0;0]+D,R4*Pc4_4+D,color2);
paint_line(R5*[Pc5_5(1);0;0]+E,R5*Pc5_5+E,color2);

t = zeros(5,1);

angles = zeros(15,times);
d_angles = zeros(3,times);
attitudes = zeros(3,times);
points = zeros(18,times);

PID1 = PID_parameter(8,10,0,0);
flag = 1;
flag1 = 1;

parameter = zeros(2,1);
parameter(1,1) = 0.0022;
parameter(2,1) = 96;

% k_t4 = parameter(1,flag1-1);
% adj1 = parameter(2,flag1-1);

parameter(1,2) = 0.003135;
parameter(2,2) = 108;

parameter(1,3) = 0.002287;
parameter(2,3) = 85;

for i=1:1:times
    t(1) = t1(flag);
    t(2) = t2(flag);
    
    pid_p = calculate_PID(PID1,(J1.angle(3)+J2.angle(3)+J3.angle(3))*rad_deg-90);
    t(3) = -1*pid_p;
    t3(flag) = t(3);
    
    t(4) = t4(flag);
    t(5) = t5(flag);
    
   [dd_angle1,dd_angle2,dd_angle3,dd_angle4,dd_angle5] = dynasic(J1,J2,J3,J4,J5,Pi_,t);
   J1.d_angle = J1.d_angle+dd_angle1*dt;
   J2.d_angle = J2.d_angle+dd_angle2*dt;
   J3.d_angle = J3.d_angle+dd_angle3*dt;
   J4.d_angle = J4.d_angle+dd_angle4*dt;
   J5.d_angle = J5.d_angle+dd_angle5*dt;
   
   J1.angle = J1.angle+J1.d_angle*dt+0.5*dd_angle1*dt*dt;
   J2.angle = J2.angle+J2.d_angle*dt+0.5*dd_angle2*dt*dt;
   J3.angle = J3.angle+J3.d_angle*dt+0.5*dd_angle3*dt*dt;
   J4.angle = J4.angle+J4.d_angle*dt+0.5*dd_angle4*dt*dt;
   J5.angle = J5.angle+J5.d_angle*dt+0.5*dd_angle5*dt*dt;
   
%     if mod(flag1,2) == 1
        n1 = D-C;
%     else
%         n1 = C-D;
%     end
    n2 = [0;1;0];
    attitudes(1,i) = asin(n1'*n2/(norm(n1)*norm(n2)))*rad_deg;
   
   angles(1:3,i) = J1.angle;
   angles(4:6,i) = J2.angle;
   angles(7:9,i) = J3.angle;
%    if mod(flag1,2) == 1;
%         angles(7:9,i) = J3.angle;
%    else
%         angles(7:9,i) = [0;0;-pi]-J4.angle;
%    end
   angles(10:12,i) = J4.angle;
   angles(13:15,i) = J5.angle;
  
   %update points
    R1 = rotate(J1.angle,0);
    R2 = R1*rotate(J2.angle,0);
    R3 = R2*rotate(J3.angle,0);
    R4 = R3*rotate(J4.angle,0);
    R5 = R4*rotate(J5.angle,0);
    
    w1_1 = J1.d_angle;
    w2_2 = R2*w1_1+J2.d_angle;
    w3_3 = R3*w2_2+J3.d_angle;
    d_angles(:,i) = w3_3;
    
    B = R1*P1_2+A;
    C = R2*P2_3+B;
    D = R3*P3_4+C;
    E = R4*P4_5+D;
    F = R5*[l5;0;0]+E;
    
    points(Point_A,i) = A;
    points(Point_B,i) = B;
    points(Point_C,i) = C;
    points(Point_D,i) = D;
    points(Point_E,i) = E;
    points(Point_F,i) = F;
    
   if mod(i,5)==0
       color1 = 'b';
       p1 = paint_line(A,B,color1);
       p2 = paint_line(B,C,color1);
       p3 = paint_line(C,D,color1);
       p4 = paint_line(D,E,color1);
       p5 = paint_line(E,F,color1);
       color2 = 'r';
        p6 = paint_line(R1*[J1.Pc(1);0;0]+A,R1*J1.Pc+A,color2);
        p7 = paint_line(R2*[J2.Pc(1);0;0]+B,R2*J2.Pc+B,color2);
        p8 = paint_line(R3*[0;0;J3.Pc(3)]+C,R3*J3.Pc+C,color2);
        p9 = paint_line(R4*[J4.Pc(1);0;0]+D,R4*J4.Pc+D,color2);
        p10 = paint_line(R5*[J5.Pc(1);0;0]+E,R5*J5.Pc+E,color2);

       pause(dt*kt);
       delete(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10);
   end
    if flag>20
        if F(2)<0.00004
            
            color1 = 'r';
            paint_line(A,B,color1);
            paint_line(B,C,color1);
            paint_line(C,D,color1);
            paint_line(D,E,color1);
            paint_line(E,F,color1);
            color1 = 'b';
            
            t1 = zeros(1,times);
            t2 = zeros(1,times);
            t3 = zeros(1,times);
            t4 = zeros(1,times);
            t5 = zeros(1,times);
            flag = 0;
            P3_4 = -P3_4;
            Pi_(7:9) = P3_4;
            R6 = R5*rotate([0;0;pi],0);
%             save('J.mat','J1','J2','J3','J4','J5');
%             J1.angle(3)*rad_deg
            [J1,J2,J3,J4,J5,A] = transform(J1,J2,J3,J4,J5,F,R6);
            flag1 = flag1+1;
            J1.d_angle
            %display
%             i
%             save('J.mat','J1','J2','J3','J4','J5');
%             d_angle = J1.d_angle*rad_deg
%             angle = J4.angle
%             attitudes(1,i)
%             w3_3
            
            theta = 270+(J4.angle(3)+J5.angle(3))*rad_deg;
            if theta>85
                temp2 = theta-85;
            else
                temp2 = 0;
            end
            i
            
            k_t4 = parameter(1,flag1-1);
            adj1 = parameter(2,flag1-1);
            for j=1:1:adj1
                t5(j) = -0.06;
            end
            
            for j=1:1:300
               t4(j) = 0.8-k_t4*j; 
            end
            for j=1:1:times
                t2(j) = -4.65;%-0.001*(attitudes(1,i)+3);
            end
            %作参考坐标系
            R = rotate([0;J1.angle(2);0],0);
            p = paint_line(R*[0.1;0;0]+A,A,'b');
            set(p,'LineWidth',2);
            p = paint_line(R*[0;0.1;0]+A,A,'g');
            set(p,'LineWidth',2);
            p = paint_line(R*[0;0;0.1]+A,A,'k');
            set(p,'LineWidth',2);
        end
    end
    flag = flag+1;   
end

R1 = rotate(J1.angle,0);
R2 = R1*rotate(J2.angle,0);
R3 = R2*rotate(J3.angle,0);
R4 = R3*rotate(J4.angle,0);
R5 = R4*rotate(J5.angle,0);

B = R1*P1_2+A;
C = R2*P2_3+B;
D = R3*P3_4+C;
E = R4*P4_5+D;
F = R5*[l5;0;0]+E;

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

% figure(2);
% hold on;
% grid on;
% plot(attitudes(1,:));
% plot(d_angles(2,:),'r');
% plot(angles(12,:)*rad_deg+115,'k');


