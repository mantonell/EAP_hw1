function ret = J(theta,T,R,Rf,C_growth,z)

% theta = [beta, gamma] is the vector of the parameters of the Lucas model.
% z = the instrument matrix.

g_T = 0;
L = T-length(z); % number of lags considered.

% Loop
for t = L+1:T
    e = [theta(1) * C_growth(t).^(-theta(2)) * R(t); ...
        theta(1) * C_growth(t).^(-theta(2)) * Rf(t)];
    e = e-1;
    g_T = g_T + kron(e,z(:,t-L));
end

g_T = g_T./(T-L);
ret = g_T'*eye(2*(2*L+1))*g_T;

return ;