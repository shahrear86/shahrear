function X = setzero(X,llim,ulim)
%This function will help you to take out the values within a limit from a Matrix. It will
% set the rest of the values out side the limit as 0. However just by doing some edit in this
% script file you can set it as 1 if will need. 

%Prepared by shahrear
%student.eco86@gmail.com

[r c]=size(X)
k=r*c


if nargin == 3
if isscalar(ulim)== 0 | isscalar(llim)== 0
    disp('error : limit should be a scalar')
else 
ulim=ulim
llim=llim
end


for i = 1:k
    if X(i)> ulim 
        X(i)=0
    end
end
for i=1:k
    if X(i)<llim
        X(i)=0
    end
end
end 
if nargin < 2
for i=1:k
    if X(i)<0
        X(i)=0
    end
end
end
end