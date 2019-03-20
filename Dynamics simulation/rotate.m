function [T] = rotate(angle,v)
x = angle(1);
y = angle(2);
z = angle(3);
C1 = [cos(z),-sin(z),0;
      sin(z),cos(z),0;
      0,0,1];
C2 = [1,0,0;
      0,cos(x),-sin(x);
      0,sin(x),cos(x);];
C3 = [cos(y),0,sin(y);
      0,1,0;
      -sin(y),0,cos(y)];

T = C2*C1*C3;
% T = [cos(y)*cos(z)+sin(y)*sin(z)*sin(x) -cos(y)*sin(z)+sin(y)*cos(z)*sin(x) -sin(y)*cos(x);
%      sin(z)*cos(x) cos(z)*cos(x) sin(x);
%      sin(y)*cos(z)-cos(y)*sin(z)*sin(x) -sin(y)*sin(z)-cos(y)*cos(z)*sin(x) cos(y)*cos(x)];
if v==1
    T = T';
end

%     [cos(z)+sin(y)*sin(z)*sin(x) -cos(y)*sin(y)+sin(y)*cos(z)*sin(x) -sin(y)*cos(x);
%      sin(z)*cos(x) cos(z)*cos(x) sin(x);
%      sin(y)*cos(z)-cos(y)*sin(z)*sin(x) -sin(y)*sin(z)-cos(y)*cos(z)*sin(x) cos(y)*cos(x)];
 