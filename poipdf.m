function poisson = poipdf(lambda,X)
%This function will return you the value of the poisson probability density
%function.
%Matlab has it's own built in function called poisspdf. We can verify the
%result by using poisspdf.

%created by: shahrear
%student.eco86@gmail.com
% © Md. Shahrear Zaman

if  nargin < 2
    disp('error: number of input should be two');
else
    if isscalar(lambda)~= 1
        disp('error: the value of the parameter should be a scalar');
    end
end
poisson = ((exp(-lambda))*(lambda).^X) ./ factorial(X);
end
