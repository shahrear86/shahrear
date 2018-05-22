function X = setval(X,col,m)
%This function will help you to replace the value of the  dummy variables
%from 1 to any other numbers. 

%Prepared by shahrear
%student.eco86@gmail.com
% © Md. Shahrear Zaman
%07.08.2017-08.08.2017

%%%%%%%%%%%%%%%%%%% 
%[r c]=size(X);
%tn=r*c;
%1:1*r
%1*r+1 : 2*r
%2*r+1: 3*r
%..........
%(c-1)*(r+1)  : c*r
%%%%%%%%%%%%%%%%%%%

if nargin ==~3
disp('error: input value should be three')
end
if nargin==3
if isscalar(col)~=1||isscalar(m)~=1
disp('error: number of the columns and replaced value of the dummy should be a scalar')
else
[r c]=size(X);
if col > c
disp('error:exceeds the number of the columns');
else
X((((col-1)*r)+1)  : col*r) = m.*X((((col-1)*r)+1)  : col*r);
end
end
end






 
