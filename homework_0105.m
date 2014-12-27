clc; clear;

%% DATA PROCESSING

% Load the data from the .xlsx file. We only need the data concerning the
% return R, the interest rate, and the consumption process.

% The returns series.
R = xlsread('DataQ4798.xlsx','D:D'); 
R = R+1;
% The risk-free returns series.
Rf = xlsread('DataQ4798.xlsx','F:F'); 
Rf = Rf./100+1;
% The consumptions series.
C = xlsread('DataQ4798.xlsx','J:J');
C_growth = C(2:end)./C(1:end-1);

% All vectors must have the same size.
T = min([length(R),length(Rf),length(C_growth)]);
R = R(end-T+1:end);
Rf = Rf(end-T+1:end);
C_growth = C_growth(end-T+1:end);

% Deletion of useless variables.
clear('C');

%% INSTRUMENTS CHOICE

% I consider the instrument vector [1 R(t-1)...R(t-L) Rf(t-1)...Rf(t-L)], 
% where L is the number of lags, and can be set arbitrarily.
L = 50;
% Instrument matrix definition.
z = ones(2*L+1,T-L);
for k=1:L
    z(1+k,:) = R(L+1-k:end-k);
    z(1+L+k,:) = Rf(L+1-k:end-k);
end

%% FIRST STEP OF THE GMM ALGORITHM: IDENTITY MATRIX

% Starting point for the fminsearch routine.
theta0 = [.8,100];
options = optimset('MaxFunEvals',600);
[theta, fval] = ...
    fminsearch(@(theta) J(theta,T,R,Rf,C_growth,z), theta0, options);