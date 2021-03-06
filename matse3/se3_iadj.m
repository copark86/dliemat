%
% Builds the se3 from the adjoint
%
function y = se3_iadj(x)

% [omega,vel] => adjoint: y = [R zeros(3);skew(t)*R R]; 
% [vel,omega] => adjoint: y = [R skew(t)*R; zeros(3) R] <=====

R = x(1:3,1:3);
b = x(1:3,4:6)*R'; % == skew(t)
t = [b(3,2) b(1,3) b(2,1)];

y = se3_set(R,t);
