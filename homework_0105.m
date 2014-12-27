clc; clear;

%% DATA PROCESSING

% Load the data from the .xlsx file. We only need the data concerning the
% return R, the interest rate, and the consumption process. Notice that,
% while the interest rates and consumptions time series are complete, the
% return R time series lacks the first 3 entries. For this reason, we
% delete the first 3 rows from the dataset.
data = xlsread('DataQ4798.xlsx','B:K');
data = data(4:end,:);

% Return series.
R = data(:,3); R = R+1;
% Interest rate series.
ir = data(:,5); ir = ir./100 + 1;
% Consumption series.
cons = data(:,9);

clear('data');

% Consumption rate = C(t+1)/C(t).
c_rate = cons(2:end)./cons(1:end-1);
% Deletion of the first component of R and ir, in order to have all vectors
% of the same length.
R = R(2:end); ir = ir(2:end);

% Sample size.
T = length(c_rate);

clear('cons');

%% INSTRUMENT CHOICE & FUNCTION DEFINITION
% I adopt as instrument the vector [1; R(t-1); ir(t-1)].
nlags = 1; % number of lags used.
theta0 = [.5,10]; % starting point for the fminsearch function.
GMM_Lucas(T,c_rate,R,ir,nlags,theta0)