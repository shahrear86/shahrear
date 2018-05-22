function gmdf = gamdf(x,a,b)

%This function will help you to create a gamma probability density function
%However MatLab has its own function gampdf. To create a gamma function we have used 
%here function gamf.

%created by: shahrear
%student.eco86@gmail.com
% © Md. Shahrear Zaman


if isscalar(a)~=1||isscalar(b)~=1
       disp('error: the value of the parameter should be a scalar')
end

if nargin < 3
    b=1;
end

if  nargin < 2
    disp('error: number of input should be atleast two');
end

a(a<=0)=NaN;
b(b<=0)=NaN;
gmdf = exp((a-1)*log(x)- a.*log(b) - log(gamf(a)) - x./b);
double(gmdf)
