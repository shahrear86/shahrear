%Create a composed diagonal matrix from the main diagonal of a
%matrix and find out the main diagonal sum
%**********************************************************
%MatLab has its own built in function to handle this.
%The command:  diag(diag(X)) returns a diagonal matrix composed of the
%diagonal elements of the original matrix and sum(diag(X)) will return you the 
%sum of the main diagonal.
%check https://de.mathworks.com/help/matlab/ref/diag.html for details
%However these built in functions will help us to verify our own function
%**********************************************************
% Reading reference:
% A Practical Introduction to
% Programming and Problem
% Solving
% By
% Stormy Attaway
%**********************************************************

%created by shahrear
%student.eco86@gmail.com 
% © Md. Shahrear Zaman

function [Y,SumDig] = sum_diagonal(X)
[row col] = size(X);

if row<col
    for i=1:row
        for j=1:row
            Z(i,j)=X(i,j)
        end
    end
else
Z=X'
end

[r c] = size(Z);

for i = 1:r
   for j = 1:r
       for i = j
           Y(i,j)=Z(i,j);
       end
   end
end
Y
% %%1st way to sum:
% %Sumdig=sum(sum(Y))
% %fprintf('Sum of the diagonal is %d\n',sumd)
% %%2nd way to sum:
sumd=0;

for k = 1:r
    for l = 1:r
        sumd=sumd+Y(k,l);
    end
end

SumDig=sumd;
fprintf('Sum of the diagonal is %d\n',sumd)
end