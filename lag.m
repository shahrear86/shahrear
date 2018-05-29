function lagadd = lag(x,l)
%created by : shahrear
%(c) Md. Shahrear Zaman
%student.eco86@gmail.com

% x = matrix
% l = number of lags
%clear all
%x = randn(10,5);
[r,c]=size(x);
%l=2;
n  = r - l;
X1 = x(1:n,:);
X2 = x(l+1:r,:);
lagadd  = [X1 X2];
end
  
  