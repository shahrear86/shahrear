%created by shahrear
%student.eco86@gmail.com 
%2017
function X = setzero(X,llim,ulim)
[r c]=size(X)
k=r*c


for nargin == 3
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

for nargin == 2
if isscalar(ulim)== 0 
    disp('error : limit should be a scalar')
else 
ulim=ulim
end
for i = 1:k
    if X(i)> ulim 
        X(i)=0
    end
end
for i=1:k
    if X(i)<0
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
