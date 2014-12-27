function ret = J(theta, T, c_rate, R, ir, nlags, W)

% theta = [beta, gamma] is the vector of the parameters of the Lucas model.
% nlags = number of lags in the instrument vector.
% W = the matrix to be used in the computation of the quadratic form.

g = 0;

% Instrument matrix definition.
z = ones(2*nlags+1,T-nlags);
for j = 1:nlags
    z(1+j,:) = R(nlags+1-j:end-j);
    z(1+nlags+j,:) = ir(nlags+1-j:end-j);
end


% Loop
for t = nlags+1:T
    e = [theta(1) * c_rate(t).^(-theta(2)) * R(t); theta(1) * c_rate(t).^(-theta(2)) * ir(t)];
    e = e-1;
    g = g + kron(e,z(:,t-nlags));
end

g = g./(T-nlags);

ret = g'*W*g;

return ;