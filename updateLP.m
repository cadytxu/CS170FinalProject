function [continueUpdate, A_ub, b_ub] = updateLP(x, N, A_ub, b_ub)
% input x: solution from LP, |V|^2 + |V| by 1 vector
%          [y11 y12 ... ynn f1 ... fn] (n = |V|)
%          y_ij = 0 if edge {i -> j} is in one of the cycles in LP solution
%               = 1 if not used in solution
%       N: = |V|, number of vertices
%       A_ub: old A_ub matrix
%       b_ub: old b_ub vector
% output: 0 if no need to run LP again, 1 otherwise
%         A_ub: k by |V|^2 + |V| matrix, k = number of oversize cycles
%              to exclude
%         b_ub: k by 1 vector, (b_ub)_i = |C_i| - 2, where C_i is one of
%              the oversize cycles

% generate graph from x
continueUpdate = 0;
A = zeros(N);
for i = 1:N
    startID = (i-1)*N+1;
    endID = i*N;
    A(i, :) = x(startID:endID);
end
Gx = digraph(A);
fx = x(endID + 1:N^2+N);


% DFS on Gx to retrieve cycles
for vID = 1:N
    if fx(vID) == 1
        T = dfsearch(Gx, vID, ...
            {'edgetonew', 'edgetodiscovered', 'discovernode'});
        v = T.Node(T.Event == 'discovernode',:);
        fx(v)=0;
        etd = T.Edge(T.Event == 'edgetodiscovered',:);
        if ~size(etd, 1)
            ME = MException('MyComponent:notCycle', ...
                'invalid LP solution');
            throw(ME)
        end
        etn = T.Edge(T.Event == 'edgetonew', :);
        edges = cat(1, etd, etn);
        cycle_size = size(edges, 1);
        if  cycle_size > 5
            continueUpdate = 1;
            s_cycle = edges(:, 1);
            t_cycle = edges(:, 2);
            Amat = zeros(N+1, N);
            for eID = 1:cycle_size
                Amat(s_cycle(eID),t_cycle(eID)) = 1;
            end
            Aflat = zeros(1, N*N + N);
            for j = 1:N
                startID = N*(j-1)+1;
                endID = N*j;
                Aflat(1, startID:endID)=Amat(j, :);
            end
            A_ub = cat(1, A_ub, Aflat);
            Gx = rmedge(Gx, s_cycle, t_cycle);            
            b_ub = cat(1, b_ub, cycle_size-2);
        end
    end
end