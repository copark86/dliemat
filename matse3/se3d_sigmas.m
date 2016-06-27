% computes sigma points for the lie group using params
%
% g is the distribution in compact form
% params is an optional parameter with:
% - alpha
% - beta
% - kappa
%
% Output:
% xp are the 2N+1 by sizeof[group] sigmapoints, with N=6 and sizeof[group]=4,4
% v  are the increments
% wi are the weights as of ut_mweights
%
% Note: for removing the mean term (zero mean assumption) clean up the
% weights
%
% Reassemble instruction (see barefoot)
%   OUTPUT AS SE3: use se3d_est
%   OUTPUT AS linear: easy
% Emanuele Ruffaldi SSSA 2015-2016

function [xp,v,wei] = se3d_sigmas(d,params)


n = 6; % dimensionality of the problem

if nargin == 1 || isempty(params)
	params = struct('alpha',0.5,'beta',2,'kappa',3-n);
end

[g,S] = se3d_get(d);

wei = ut_mweights2(n,params.alpha,params.beta,params.kappa);
c = wei.WC;

C = cholcov2(S); % 6x6 -> 

% first compute the sigma points stored ad 4x4 in this implementation
xp = zeros(2*n+1,4,4);
xp(1,:,:) = g; % not weighted
v = zeros(2*n+1,6);
for I=1:n
    psi = c(I)*C(:,I);
    v(I+1,:) = psi;
    v(I+1+n,:) = -psi;
	xp(I+1,:,:) = se3_mul(se3_exp(psi),g); % weighted local motion
	xp(I+1+n,:,:) = se3_mul(-se3_exp(psi),g); % weighred local motion
end

% Linear form
%X(1,:) = mu(:)';
%for I=1:L
%    X(I+1,:) = X(1,:) + c(I)*S(I,:);
%    X(I+1+L,:) = X(1,:) - c(I)*S(I,:);
%end
