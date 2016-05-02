function [  ] = find_cycles( G )
%FIND_CYCLES Summary of this function goes here
%   Detailed explanation goes here
numNodes = size(G,1); 
for n = 1:numNodes
   [D,P]=graphtraverse(G,n);
   for d = D
       if G(d,n)
           graphpred2path(P,d)
       end
   end
   G(n,:)=0; 
end
end

