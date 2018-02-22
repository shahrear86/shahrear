%function N = npdf(mu,sigma,X)

%This function will return you the value of the normal probability density function for the constant mean and variance.
%Matlab and Octave both have own built in function called normpdf. We can verify the
%result by using normpdf.


%created by: shahrear
%student.eco86@gmail.com
mu=0
sigma=4
X=(-100:0.1:100)

if nargin > 3
    disp ('error: The number of the input should be three')
else
     if isscalar(mu)~=1 || isscalar(sigma)~=1
        disp('error: parameter should be a scalar')
     end
end

sigma(sigma <= 0) = NaN;
Y = 1/(sigma*sqrt(2*pi));
Z = ((X-mu).^2 )/ (2*sigma^2);
N = Y.*exp(-Z);

plot(X,N)
xlabel ("X");
ylabel ("f(X)");
legend(sigma);
%end






