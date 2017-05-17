function [a,b,c] = CalcFirstOrder(p1,p2)
%Calcration of first order equation from 2 points
a = p1(1,2) - p2(1,2);
b = -(p1(1,1) - p2(1,1));
c = (p1(1,2)-p2(1,2))*-1*p1(1,1)+p1(1,2)*(p1(1,1)-p2(1,1));
end

