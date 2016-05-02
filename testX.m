A = zeros(N);
for i = 1:N
    startID = (i-1)*N+1;
    endID = i*N;
    A(i, :) = x(startID:endID);
end
Gx = digraph(A);
figure
plot(Gx)