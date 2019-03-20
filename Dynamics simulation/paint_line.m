function p = paint_line(A,B,c)

x(1) = A(3);
x(2) = B(3);
%y = [0,0];
% y(1) = A(2);
% y(2) = B(2);
% 
% z(1) = A(3);
% z(2) = B(3);

z(1) = A(2);
z(2) = B(2);

y(1) = A(1);
y(2) = B(1);

p = plot(y,z,c);
% p = plot3(x,y,z,c);
