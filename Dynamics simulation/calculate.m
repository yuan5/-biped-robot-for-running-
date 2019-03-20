function calculate(f)

% clear all
% close all
% clc

g = 9.8;
rad_deg = 180/pi;
deg_rad = pi/180;

dt= 0.001;
times = 400;
max_angle = 119.4884*deg_rad;
min_angle = 60*deg_rad;
kt = 10;
X = [1;0;0];
Y = [0;1;0];
Z = [0;0;1];
E1 = [0 0 0;0 0 0;0 0 1 ];
A = [ -0.1145;-0.0001;0.0003];

Point_A = 1:3;
Point_B = 4:6;
Point_C = 7:9;
Point_D = 10:12;
Point_E = 13:15;
Point_F = 16:18;

l1 = 221.7/1000;
dd_angle1 = zeros(3,1);

l2 = 203.25/1000;
P1_2 = [l1;0;0];
dd_angle2 = zeros(3,1);

l3 = 178.77/1000;
P2_3 = [l2;0;0];
dd_angle3 = zeros(3,1);

l4 = 203.25/1000;
P3_4 = [0;0;-l3];
dd_angle4 = zeros(3,1);

l5 = 221.7/1000;
P4_5 = [l4;0;0];
dd_angle5 = zeros(3,1);

load data/angle4-2.14_t2/233_95/210_108/J

R1 = rotate(J1.angle,0);
figure(1);
O = [0;0;0];
B = R1*P1_2+O;
color1 = 'b';
p1 = paint_line(A,B,color1);
hold on;
grid on;
paint_line([0;0;0],[0.5;0;0],'r');
paint_line([0;0;0],[0;0.5;0],'b');
paint_line([0;0;0],[0;0;0.5],'k');
delete(p1);

% P3_4 = -P3_4;
% Pi_(7:9) = P3_4;

[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10] = paint_model(A,J1,J2,J3,J4,J5,l1,l2,P3_4,l4,l5);
set(p1,'Color','r');
set(p2,'Color','r');
set(p3,'Color','r');
set(p4,'Color','r');
set(p5,'Color','r');
set(p6,'Color','r');
set(p7,'Color','r');
set(p8,'Color','r');
set(p9,'Color','r');
set(p10,'Color','r');

t1 = zeros(1,times);
t2 = zeros(1,times);
t3 = zeros(1,times);
t4 = zeros(1,times);
t5 = zeros(1,times);

t1 = t1+0;
t2 = t2-5.3;

Pi_ = zeros(12,1);
Pi_(1:3) = P1_2;
Pi_(4:6) = P2_3;
Pi_(7:9) = P3_4;
Pi_(10:12) = P4_5;

% P3_4 = -P3_4;
% Pi_(7:9) = P3_4;

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


t = zeros(5,1);

angles = zeros(15,times);
d_angles = zeros(3,times);
attitudes = zeros(3,times);
% points = zeros(18,times);

PID1 = PID_parameter(8,10,0,0);
flag = 1;
flag1 = 1;

 

i=1;
% for f=204:1:210

P3_4 = -P3_4;
Pi_(7:9) = P3_4;

% 0.0018
data = zeros(5,25);
thumb = 1;
    k_t4 = 0.0010;%+(260-f)*(0.0025-0.0018)/29;%+(240-f)*0.000037;%+(260-f)*0.00003;%-0.00005*k;
    for m=0:1:25
        adj1 = 85+m;%+2*(attitudes(1,i)+3);% - 500*(J4.angle(3)+2.0353);
%         k_t4 = k_t4-0.0002*k;
        for n = 1:1:300
            k_t4 = 0.000005+k_t4;%+0.01*(J4.angle(3)+2.0353);%-0.0001*(attitudes(1,i)+4)
            clear J1 J2 J3 J4 J5;
            load data/angle4-2.14_t2/233_95/210_108/J;
            
            R1 = rotate(J1.angle,0);
            R2 = R1*rotate(J2.angle,0);
            R3 = R2*rotate(J3.angle,0);
            R4 = R3*rotate(J4.angle,0);
            R5 = R4*rotate(J5.angle,0);
            
            F = [-0.2304;0.0000;-0.1747];
            R6 = R5*rotate([0;0;pi],0);
            [J1,J2,J3,J4,J5,A] = transform(J1,J2,J3,J4,J5,F,R6);
            
%             [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10] = paint_model(A,J1,J2,J3,J4,J5,l1,l2,P3_4,l4,l5);
%             J4.angle(3) = -1.95;
%             J5.angle(3) = -1.59;
%             J1.d_angle
%             J1.d_angle(1) = -0.5;

            for j=1:1:adj1
                t5(j) = -0.06;
            end
            for j=1:1:300
               t4(j) = 0.8-k_t4*j;
            end
            for j=1:1:times
                t2(j) = -4.65;
            end

            for i=1:1:times
                flag = flag+1;
                t(1) = t1(i);
                t(2) = t2(i);

                pid_p = calculate_PID(PID1,(J1.angle(3)+J2.angle(3)+J3.angle(3))*rad_deg-90);
                t(3) = -1*pid_p;
                t3(i) = t(3);

                t(4) = t4(i);
                t(5) = t5(i);

               [dd_angle1,dd_angle2,dd_angle3,dd_angle4,dd_angle5] = dynasic_line(J1,J2,J3,J4,J5,Pi_,t);
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

                    n1 = D-C;
                n2 = [0;1;0];
                attitudes(1,i) = asin(n1'*n2/(norm(n1)*norm(n2)))*rad_deg;

               angles(1:3,i) = J1.angle;
               angles(4:6,i) = J2.angle;
               angles(7:9,i) = J3.angle;
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

%                if mod(i,5)==0
%                    [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10] = paint_model(A,J1,J2,J3,J4,J5,l1,l2,P3_4,l4,l5);
% %                    pause(dt);
% %                    delete(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10);
%                end
                if flag>20
                    if F(2)<0.00004
%                         paint_model(A,J1,J2,J3,J4,J5,l1,l2,P3_4,l4,l5);
                        flag = 0;
    %                     %作参考坐标系
%                         R = rotate([0;J1.angle(2);0],0);
%                         p = paint_line(R*[0.1;0;0]+A,A,'b');
%                         set(p,'LineWidth',2);
%                         p = paint_line(R*[0;0.1;0]+A,A,'g');
%                         set(p,'LineWidth',2);
%                         p = paint_line(R*[0;0;0.1]+A,A,'k');
%                         set(p,'LineWidth',2);
                        break;
                    end
                end
            end
            k_t4
            adj1
            i
            paint_model(A,J1,J2,J3,J4,J5,l1,l2,P3_4,l4,l5);
            if i <= f
                paint_model(A,J1,J2,J3,J4,J5,l1,l2,P3_4,l4,l5);
%                     %作参考坐标系
                R = rotate([0;J1.angle(2);0],0);
                p = paint_line(R*[0.1;0;0]+A,A,'b');
                set(p,'LineWidth',2);
                p = paint_line(R*[0;0.1;0]+A,A,'g');
                set(p,'LineWidth',2);
                p = paint_line(R*[0;0;0.1]+A,A,'k');
                set(p,'LineWidth',2);
                
                data(1,thumb) = adj1;
                data(2,thumb) = k_t4;
                data(3,thumb) = F(1);
                data(4,thumb) = attitudes(1,i);
                data(5,thumb) = J1.d_angle(1);
                thumb = thumb+1;
                break;
            end
        end
    end
%     number = 200+k;
    filename = ['data/angle4-2.14_t2/233_95/210_108/time_',num2str(f),'.mat'];
%     save('data/dvx_1.0/time_200','data');
       save(filename,'data');
%     266+k
%     pause(0.01);
% end
[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10] = paint_model(A,J1,J2,J3,J4,J5,l1,l2,P3_4,l4,l5);

figure(2);
hold on;
grid on;
plot(data(1,:),data(2,:));

% plot(attitudes(1,1:i));
% plot(d_angles(2,1:i),'r');
% plot(angles(12,1:i)*rad_deg+115,'k');

