function MSE = mserror(x,y,cons,beta) 
%created by: shahrear
%student.eco86@gmail.com
% © Md. Shahrear Zaman
%reference: https://en.wikipedia.org/wiki/Mean_squared_error

% within sample mse of the predictor
% x is the matirics of the exogenous variable
% y is the vector of observed values of the variable being predicted  
% cons is the vector of the constant
% beta is the vector of the co-efficients 
% yhat is the vector the n predictions 
         n=size(x);
         N=n(1);
         cons=cons;
         yhat = cons + x*beta';
         MSE = sum((yhat - y).^(2))/N
end






