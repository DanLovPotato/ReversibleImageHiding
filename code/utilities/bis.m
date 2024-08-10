function [va,av]=bis(b)

[m,n]=size(b);
av=mean(b(:));
va=std(b(:),1);
%   a=a/(max(max(b))-min(min(b)));

%   sum=0;
%   k=0;
%   for i=1:m
%       for j=1:n
%           if(b(i,j)>av)
%               k=k+1;
%      sum=sum+b(i,j);
%           end
%       end
%   end
%   sum=sum/k;
%    a=a/(sum-av);