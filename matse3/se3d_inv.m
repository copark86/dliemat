% inverse of the distribution
%
% Emanuele Ruffaldi 2015
function y=se3d_inv(a)

[ga,ca] = se3d_get(a); % extract 
A = se3_adj(ga);    % adjoint of inverse
y = se3d_set(se3_inv(ga),A*ca*A');
