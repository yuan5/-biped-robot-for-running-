classdef PID_parameter
    properties
        P = zeros(1,1);
        I = zeros(1,1);
        D = zeros(1,1);
        I_out = zeros(1,1);
    end
    methods
        function obj = PID_parameter(P,I,D,I_out)
            obj.P = P;
            obj.I = I;
            obj.D = D;
            obj.I_out = I_out;
        end
    end
end