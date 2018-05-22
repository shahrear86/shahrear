%If you will find that the number of the row in a matrix is smaller than
%the number of the column then this loop will help you to create sub
%matrices where the number of the row and column are the equal.

%created by shahrear
%student.eco86@gmail.com 
% © Md. Shahrear Zaman

[r c]=size(X)
i=c-r+1
if r < c    
for i = 0:c-r+1
Y =X(:,(1:r)+i)
eval(['Y' num2str(i) ' = Y'])
end
else
    Y(:,:)=X(:,:)
end
