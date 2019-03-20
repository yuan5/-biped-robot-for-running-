function [dv] = calcutate_dvc(dw,Pc,w,dv1)

dv = cross(dw,Pc)+cross(w,cross(w,Pc))+dv1;