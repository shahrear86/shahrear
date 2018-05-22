function X = setvaluedummy(X,detcol,n,m)

%This code will help you to set any value for any dummy variables 

%created by shahrear
%student.eco86@gmail.com 
% © Md. Shahrear Zaman
%07-08-2017

*******************************************
% X = independent variables
% detcol= detect the column
% n = given value
% m = converted value
 
*******************************************
% easy way:
% detcol=l
% [r c] = size(X);
% X1=X(:,l);
% X1 = X1*m;
*******************************************

[r c] = size(X)

for l = detcol 
    X =  X(:,l);
    for i = 1 : r
    if X(i,l)= n
    X(i,l)= m;
    end
    end
 end
 

    
       
    
