function [ bfs_cycle ] = bfs_find_cycle(G, s, visited)
%DFS_FIND_CYCLES Summary of this function goes here
%Use DFS to find a cycle from the node s 
%Output the array of vertices 
%adj_matrix = dlmread('phase1-processed/423.in');
%adj_matrix(1:2,:) = [];
%M_transpose = M.';
%G = digraph(adj_matrix); 
%plot(G); 


bfs_cycle=[];


events = {'edgetonew','edgetodiscovered','edgetofinished','startnode'};
T = bfsearch(G,s,events,'Restart',false); 
%display(T);
edgefin = T.Edge(T.Event == 'edgetofinished',:);
edgenew = T.Edge(T.Event == 'edgetonew',:);
prev_node = 0;

if ~isempty(edgefin)
    for row = 1:size(edgefin, 1)
        if (edgefin(row, 2) == s) && ~visited((edgefin(row, 1)));
            prev_node = edgefin(row, 1);
            bfs_cycle = [prev_node bfs_cycle]; 
            %display(cycle);
            break; 
        end 
    end  
%display(T);
%display(edgenew);
%display(edgedis);
end

if prev_node ~= 0
    while (prev_node ~= s) && ~isempty(bfs_cycle)
        for row = 1:size(edgenew, 1)
            if (edgenew(row, 2) == prev_node) && ~visited((edgenew(row, 1)))
                prev_node = edgenew(row, 1);
                bfs_cycle = [prev_node bfs_cycle];
                %display(cycle);
            elseif edgenew(row, 2) == prev_node 
                bfs_cycle = [];
                break;
            end 
        end 
    end
end 

if length(bfs_cycle) > 5
    bfs_cycle = [];
elseif length(bfs_cycle) == 4
    bfs_cycle = [bfs_cycle 0];
elseif length(bfs_cycle) == 3
    bfs_cycle = [bfs_cycle 0 0];
elseif length(bfs_cycle) == 2
    bfs_cycle = [bfs_cycle 0 0 0];
end 
    

