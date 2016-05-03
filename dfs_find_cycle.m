function [ dfs_cycle ] = dfs_find_cycle(G, s, visited)
%DFS_FIND_CYCLES Summary of this function goes here
%Use DFS to find a cycle from the node s 
%Output the array of vertices 
%adj_matrix = dlmread('phase1-processed/423.in');
%adj_matrix(1:2,:) = [];
%M_transpose = M.';
%G = digraph(adj_matrix); 
%plot(G); 


dfs_cycle=[];
%s = 1; 

events = {'edgetonew','edgetodiscovered','edgetofinished','startnode'};
T = dfsearch(G,s,events,'Restart',true); 
edgedis = T.Edge(T.Event == 'edgetodiscovered',:);
edgenew = T.Edge(T.Event == 'edgetonew',:);
prev_node = 0;

if ~isempty(edgedis)
    for row = 1:length(edgedis)
        if (edgedis(row, 2) == s) && ~visited((edgedis(row, 1)));
            prev_node = edgedis(row, 1);
            dfs_cycle = [prev_node dfs_cycle]; 
            %display(cycle);
            break; 
        end 
    end  
%display(T);
%display(edgenew);
%display(edgedis);
end

if prev_node ~= 0
    while (prev_node ~= s) && ~isempty(dfs_cycle)
        for row = 1:length(edgenew)
            if (edgenew(row, 2) == prev_node) && ~visited((edgenew(row, 1)))
                prev_node = edgenew(row, 1);
                dfs_cycle = [prev_node dfs_cycle];
                %display(cycle);
            elseif edgenew(row, 2) == prev_node 
                dfs_cycle = [];
                break;
            end 
        end 
    end
end 

if length(dfs_cycle) > 5
    dfs_cycle = [];
elseif length(dfs_cycle) == 4
    dfs_cycle = [dfs_cycle 0];
elseif length(dfs_cycle) == 3
    dfs_cycle = [dfs_cycle 0 0];
elseif length(dfs_cycle) == 2
    dfs_cycle = [dfs_cycle 0 0 0];
end 
    

