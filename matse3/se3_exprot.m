%
% Exponential from algebra to group
%
function y = se3_exp(x)

omega = x(4:6);


% first log of R
%simplify(taylor(sin(x)/x,x,0,'Order',6))
%       x^4/120 - x^2/6 + 1
%simplify(taylor((1-cos(x))/x/x,x,0,'Order',6))
%       x^4/720 - x^2/24 + 1/2
%simplify(taylor((1-sin(x)/x)/x/x,x,0,'Order',6))
%       x^4/5040 - x^2/120 + 1/6
theta = norm(omega);
if theta < 1e-12
    % Original
    %     A = 1;
    %     B = 0.5;
    %     C = 1/6;
    %     S = zeros(3);
    %     R = eye(3) + A*S + B*S^2;
    %     V = eye(3) + B*S + C*S^2;
    
        N = 10;
        R = eye(3);
        xM = eye(3);
        cmPhi = skew(omega);
        for n = 1:N
            xM = xM * (cmPhi / n);
            R = R + xM;
        end
        
        % Project the resulting rotation matrix back onto SO(3)
        R = R / sqrtm( R'*R ) ;
    
else
    %Original
    %A = sin(theta)/theta;
    %B = (1-cos(theta))/(theta^2);
    %C = (theta-sin(theta))/(theta^3);
    %S = skew(omega);
    %R = eye(3) + A*S + B*S^2;
    %V = eye(3) + B*S + C*S^2;
    
    %Barfoot
        
        axis = omega/theta;
        cp = cos(theta);
        sp = sin(theta);
        sa = skew(axis);
        
        R = cp*eye(3) + (1-cp)*axis*(axis') + sp*sa;
       
    
end

y = eye(4);
y(1:3,1:3) = R;

function S = skew(v)
S = [  0   -v(3)  v(2)
    v(3)  0    -v(1)
    -v(2) v(1)   0];

