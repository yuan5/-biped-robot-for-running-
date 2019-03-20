classdef Joint
   properties
       m = zeros(1,1);
       I = zeros(3,3);
       Pc = zeros(3,1);
       angle = zeros(3,1);
       d_angle = zeros(3,1);
   end
    methods
        function obj = Joint(m,I,Pc,angle,d_angle)
            obj.m = m;
            obj.I = I;
            obj.Pc = Pc;
            obj.angle = angle;
            obj.d_angle = d_angle;
        end
    end
end