% created by : Md. Shahrear Zaman
%(c) Md. Shahrear Zaman
% shahrear.zaman1971@gmail.com
% student.eco86@gmail.com
% date 13/07/2020 time 07:18P.M. % date 13/09/2020 time 05:19P.M. % date 14/09/2020 time 07:16P.M.
clear all
% Read the data
% Time series or cross section data or mixed
load ausrice.txt
load goldprice.txt
load paper.txt
load jute.txt
%load testexo.txt
%load Years.txt
%Part-1%%%%%%%%%%%%%%%%%%%%%%Forecast And Graph%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y = ausrice
%year = Years                             
[T  c] = size(Y) ;
% Let's consider we have done already the standard stationary test
% Let's consider we have done already the standard lag selection test 
lag1 =[0,[Y(1:T-1)]']; % Taking 1 lag of the endogenous variable
% lag2 =[0,0,[Y(2:T-2)]']; % Taking 2 lag of the endogenous variable and so on

X=[lag1' goldprice(1:40) paper jute]; % Packing the exogenous part
k = columns(X);

[count, value] = runlength (Y); % Counting the number of the each value  
N = sum(count);

prob = count/N; % Calculating the probability of the each value
tprob = sum(prob);
 if tprob =~ 1.0000e+1000
    disp(" Total probability should be one ")
    else
    disp("The probability of the production in each year : ") , disp(prob)
 end

PP = [ ]
 for i =1:T
    PP1 = (rows(Y(find(Y == Y(i))))/rows(Y))
    PP =[PP PP1]
 end

mu  = sum(PP*Y); % Calculating the population mean
s   = sum(Y)/N; % Calculating the sample mean

if mu =~ s
    disp(" population and sample mean are not the the same")
    else
    disp("we can consider mu = :"), disp(mu=s) 
end

sigma2 = sum(((Y-mu).^2)'*PP'); % Calculating the population variance
sigma_hat2 = sum((Y- mean(Y)).^2)/(T - k); % Calculating the sample variance

% Taking volatility with the t-distribution of the endogenous variable
% Iterate the process to generate 1000 replication of the endogenous variable with 1000 t-values
betaols = inv(X'*X)*X'*Y;

barn = 400;
replication = 600;
s = barn + replication ;
t = [ ];
 for itr = 1 : s
   %tvalu =  (((sum(Y)+(randn(1))) /rows(Y)) - mu) / sqrt(sigma2/T);
   tvalu =  ((((sum(Y)+(randn(1))) /rows(Y)) - mu)+(100*randn(1))) / sqrt(sigma2/T);
   t = [t  [tvalu]];
   err = Y.*t - (X*betaols);
%   err = (Y - (X*betaols)).*t.^2;
   %err = Y.*t*10 - (X*betaols);
 end
 
Yhat = X*betaols
errprc = prctile(err',[10,20,30,40,50,60,70,80,90]); 
%................................................................................................... 

x1 = randn(1,50);  % Random number generator for the variance of the hypothetical data
y1 = mu+gamma(x1); % Hypothetical data with gamma distribution
%y1 = x1

[r1 c1] = size(y1);
N1 = c1;
v = N1;
m_bar = sum(y1)/N1;
[r2 c2] = size(Y);
T = r2;

y_bar = sum(Y)/T;
% Combining the mean of the hypothetical endogenous variable and the real endogenous variable
m_star = (v/(v+T))*m_bar + (T/(v+T))*y_bar;

% Set up the prior values
mu_0 =  0
s2_0 = 5
v_0 = 10
beta_0 = 0

s2 = sum((Y-y_bar).^2)/(T-1)
% Combining the variance of the hypothetical endogenous variable and the real endogenous variable
% instead of n and n0 , I have used v and v_0
V_0 =  (( v_0*s2_0) + sum((y1-m_bar).^2) +  ( (v_0*v)/(v_0+v).*(mu_0 - m_bar ).^2 ) )/(v_0+v) 

%Posterior 
mu_bar = m_star + mu_0.*sqrt((V_0/(v+T)))
betaols_bar = (((((V_0).^(-1))./(((V_0).^(-1))+ sum((X.^2),1)))*beta_0) 
                    +  (betaols'.*((sum((X.^2),1))./(((V_0).^(-1))+ sum((X.^2),1)))))

% Taking volatility with the t-distribution of the endogenous variable
% Iterate the process to generate 1000 replication of the endogenous variable with 1000 t-values

barn = 400;
replication = 600;
s = barn + replication ;
t3 = [ ];
 for itr = 1 : s
   %tvalu3 =  (((sum(Y)+ 10*randn(1)) /rows(Y)) - mu_bar) / sqrt(sigma2/T);
   %tvalu3 =  ((((sum(Y)+ 10*randn(1)) /rows(Y)) - mu_bar) / sqrt(sigma2/T))+10*randn(1);
   tvalu3 =  (((((sum(Y)+ randn(1)) /rows(Y)) - mu_bar)+(100*randn(1))) / sqrt(sigma2/T));
   t3 = [t3  [tvalu3]];
   %err3 = Y - (X*betaols_bar')*t3;
   %err3 = (Y - (X*betaols_bar')).*t3;
   %err3 = Y^t3 - (X*betaols_bar');
 end

err3 = Y.*t3 - (X*betaols_bar');
Yhat3 = X*betaols_bar'
errprc3 = prctile(err3',[10,20,30,40,50,60,70,80,90]); 

% Forecast:
% Forecast with ordenary least square
forecast = [[ones(9,1)*Y(1:T-5)'],[Yhat(T-5:T)'+ errprc(1:9,T-5:T)]]' 
% Forecast with ordenary least square by using Bayesian Econometric techniques
forecast3 = [[ones(9,1)*Y(1:T-5)'],[Yhat3(T-5:T)'+ errprc3(1:9,T-5:T)]]' 
%*******************************************************************************
fprintf('**********************************************************\n')
fprintf('number of the observation = %9.4f \n',N);
fprintf('Population mean of endogenous variable = %9.4f \n',mu);
fprintf('Population variance of endogenous variable = %9.4f \n',sigma2);
fprintf('Posterior population mean of endogenous variable = %9.4f \n',mu_bar);
fprintf('OLS = %9.4f \n',betaols);
fprintf('barn in = %9.4f \n',barn);
fprintf('replication = %9.4f \n',replication);
fprintf('Posterior OLS = %9.4f \n',betaols_bar);
fprintf('**********************************************************\n') 

figure (); plot(forecast);
grid on;
ylabel('Forecasted Variable')
xlabel('Years')
title('Test-case: normal OLS');

figure (); plot(forecast3);
grid on;
ylabel('Forecasted Variable')
xlabel('Years')
title('Test-case: Bayesian OLS'); 
%Part-2%%%%%%%Information About The Data And Forecast Performances%%%%%%%%%%%%%%
M = eye(T) - X*(inv(X'*X))*X';
SST = Y'*M*Y;
SSR = betaols'*X'*M*X*betaols;
SSE = (Y - Yhat)'*(Y -Yhat);
SSR_bar = (betaols_bar')'*X'*M*X*(betaols_bar');
SSE_barn_rep = errprc'*errprc;
R2 = SSR / SST
R2_bar = SSR_bar / SST
sigma2 = sum(((Y-mu).^2)'*PP')
sigma2_posterior = sum(((Y-mu_bar).^2)'*PP')
var_b = sigma2*inv(X'*X);
var_b_posterior = sigma2_posterior*inv(X'*X);
RMSE = sqrt(sum((Y - Yhat).^2)/T)
Theil_U = sqrt((sum((Y - forecast(1:40,:)).^2)/T)/((sum(Y.^2))/T)) %Adjust the number here
Theil_U_bayesianOLSforecast = sqrt((sum((Y - forecast3(1:40,:)).^2)/T)/((sum(Y.^2))/T)) %Adjust the number here
%Part-3%%%%%%%Probability Density Functions and Likelihood Function%%%%%%%%%%%%%
beta_ridge_regress = inv( inv((((Y-Yhat)'*(Y - Yhat))/((size(Y,1))- size(X,2)))/((size(Y,1))+(size(y1,2))))  +  X'*X )*( (betaols / ((((Y-Yhat)'*(Y - Yhat))/((size(Y,1))- size(X,2)))/((size(Y,1))+(size(y1,2)))) ) + X'*Y)
M_star = inv( inv((((Y-Yhat)'*(Y - Yhat))/((size(Y,1))- size(X,2)))/((size(Y,1))+(size(y1,2))))  +  X'*X )

%beta = [(beta_ridge_regress - (sigma2)*M_star):0.1:(beta_ridge_regress + (sigma2)*M_star)]
%pdf_beta_sigma2YX = ((1/(2*pi*sigma2))^((size(X,2))/2))*((abs(M_star))^(-1/2))*exp((-1/(2*sigma2)).*((beta - beta_ridge_regress)'*inv(M_star)*(beta - beta_ridge_regress)))

pdf_beta_sigma2YX = ((1/(2*pi*sigma2))^((size(X,2))/2))*((abs(M_star))^(-1/2))*exp((-1/(2*sigma2)).*((beta_ridge_regress-betaols)'*inv(M_star)*(beta_ridge_regress-betaols)))

N = v;
N_star = N + T;
Lambda = (((Y-Yhat)'*(Y - Yhat))/((size(Y,1))- size(X,2)))*(((size(y1,1))- size(X,2)))
Lambda_star = Lambda + ((Y-X*beta_ridge_regress)'*(Y - X*beta_ridge_regress)) + (beta_ridge_regress-betaols)'*(1/((((Y-Yhat)'*(Y - Yhat))/((size(Y,1))- size(X,2)))/((size(Y,1))+(size(y1,2)))))*(M_star)*(X'*X)*(beta_ridge_regress-betaols)

%X'*X
%M_star
%Lambda
%(Y-X*beta_ridge_regress)'
%(Y-X*beta_ridge_regress)
%(beta_ridge_regress - mu)'*M_star*(X'*X)*(beta_ridge_regress - mu)
%(1/((((Y-Yhat)'*(Y - Yhat))/((size(Y,1))- size(X,2)))/((size(Y,1))+(size(y1,2)))))

pdf_sigma2_yX = ((sqrt(sigma2))^(-2*abs(N_star/2) -1 ))*(((Lambda_star)/2)^(N_star/2))*(1/gammaln(N/2))*exp(-(1/2)*Lambda_star*((sqrt(sigma2))^(-2)))

%((sqrt(sigma2))^(-2*abs(N_star/2) -1 ))
%(((Lambda_star)/2)^((N_star/2)))
% (1/gamma(N_star/2))
% exp(-(1/2)*Lambda_star*((sqrt(sigma2))^(-2)))

Likelihood_BetaSigma_YX = diag(pdf_beta_sigma2YX).*diag(pdf_sigma2_yX)

pdf_sigma2_yX = ((sqrt(sigma2))^(-2*abs(N_star/2) -1 ))*(((Lambda)/2)^(N_star/2))*(1/gammaln(N/2))*exp(-(1/2)*Lambda*((sqrt(sigma2))^(-2)))

MBetaSigmaY_X = inv(eye(size(Y,1)) + X*inv((((Y-Yhat)'*(Y - Yhat))/((size(Y,1))- size(X,2)))/((size(Y,1))+(size(y1,2))))*X')

Likelihood_BetaSigmaY_X = diag(pdf_beta_sigma2YX)*diag(pdf_sigma2_yX)*diag(((1/(2*pi*sigma2))^((size(Y,1))/2)).*((abs(MBetaSigmaY_X))^(-1/2)).*exp((-1/(2*sigma2)).*((Y-X*betaols)'*inv(MBetaSigmaY_X)*(Y-X*betaols))))'
L_YBS_X =(Likelihood_BetaSigmaY_X')

%plot(beta,diag(pdf_beta_sigma2YX))
%((1/(2*pi*sigma2))^((size(X,2))/2))
%(abs(M_star))^(-1/2)
%exp((-1/(2*sigma2))*(beta - beta_ridge_regress)'*inv(M_star)*(beta - beta_ridge_regress))

Author = char([35,32,97,117,116,104,111,114,58,32,109,100,46,115,104,97,104,114,101,97,114,32,122,97,109,97,110],10)

