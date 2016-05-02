findInitialCycles_196
N = 5;
halfAeq = Aeq(1:N, :);
Amat = zeros(N);
for i = 1:N
    startID = (i-1)*N+ 1;
    endID = i*N;    
    Amat(i, :) = halfAeq(i, startID: endID);
end
Ga = digraph(Amat);
figure
plot(Ga)