%(c)Md.Shahrear Zaman
%shahrear.zaman1971@gmail.com
%student.eco86@gmail.com
%28/09/2020
function YL = lagadjust(lag,Y)
l=lag; % Lag selection
[T,c] = size(Y);
YL =[];
YL =[zeros(1,l),[Y(1:T-l)]']; % Adjust lag selection
end

