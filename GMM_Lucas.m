function [theta_GMM, fval] = GMM_Lucas(T, c_rate, R, ir, nlags, theta0)

% theta0: starting point

% First step of the GMM: W = Identity matrix
I = eye(2*(2*nlags+1));
[theta_GMM, fval] = fminsearch(@(theta) J(theta,T,c_rate,R,ir,nlags,I), theta0);

end