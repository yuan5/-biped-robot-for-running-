function [value] = calculate_PID(PID_parameter,error)

P_out = PID_parameter.P*error;
PID_parameter.I_out = PID_parameter.I_out+PID_parameter.I*error;
value = P_out+PID_parameter.I_out;
if value>1.2
    value = 1.2;
end
if value<-1.2
    value = -1.2;
end

