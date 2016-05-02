function [ cycle ] = dfs_find_cycle(G, s, visited)
%DFS_FIND_CYCLES Summary of this function goes here
%Use DFS to find a cycle from the node s 
%Output the array of vertices 
%adj_matrix = dlmread('phase1-processed/423.in');
%adj_matrix(1:2,:) = [];
%M_transpose = M.';
%G = digraph(adj_matrix); 
%plot(G); 


cycle=[];
%s = 1; 

events = {'edgetonew','edgetodiscovered','edgetofinished','startnode'};
T = dfsearch(G,s,events,'Restart',true); 
edgedis = T.Edge(T.Event == 'edgetodiscovered',:);
edgenew = T.Edge(T.Event == 'edgetonew',:);
prev_node = 0;

if ~isempty(edgedis)
    for row = 1:length(edgedis)
        if (edgedis(row, 2) == s) & ~visited((edgedis(row, 1)));
            prev_node = edgedis(row, 1);
            cycle = [prev_node cycle]; 
            display(cycle);
            break; 
        end 
    end  
display(T);
display(edgenew);
display(edgedis);
end

if prev_node ~= 0
    while (prev_node ~= s) & ~isempty(cycle)
        for row = 1:length(edgenew)
            if (edgenew(row, 2) == prev_node) & ~visited((edgenew(row, 1)))
                prev_node = edgenew(row, 1);
                cycle = [prev_node cycle];
            elseif edgenew(row, 2) == prev_node 
                cycle = [];
                break;
            end 
        end 
    end
end 

if length(cycle) > 5
    cycle = [];
elseif length(cycle) == 4
    cycle = [cycle 0];
elseif length(cycle) == 3
    cycle = [cycle 0 0];
elseif length(cycle) == 2
    cycle = [cycle 0 0 0];
end 
    

