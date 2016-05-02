function [ cycles ] = greedy_find_cycles( )
%GREEDY_CYCLES Summary of this function goes here
%   Detailed explanation goes here

fid = fopen('UNBREAKABLE3.in', 'r');
num_of_v_str = fgetl(fid);
num_of_v = str2num(num_of_v_str);

children = strread(fgetl(fid));
num_of_children = length(children);

adj_matrix = dlmread('UNBREAKABLE3.in');
adj_matrix(1:2,:) = [];
%M_transpose = M.';
G = digraph(adj_matrix); 
plot(G); 
fclose(fid);

visited = zeros(1, num_of_v); 
weight_arr = ones(1, num_of_v);
for v = 1:num_of_children
    weight_arr(children(v)+1) = 2;
end 
    
cycles = [];
achievement = 0; 


display('children ------');
for i = 1: num_of_children
    child = children(i)+1;
    if ~visited(child)
        cycle = dfs_find_cycle(G,child,visited);
        if ~isempty(cycle)
            %G = rmnode(G, cycle);
            display(cycle);
            for i = 1: length(cycle)
                if ~(cycle(i) == 0)
                    visited(cycle(i)) = 1;
                    achievement = achievement + weight_arr(cycle(i));
                end
            end 
            cycles = [cycles;cycle]; 
        end   
    end
end

display('adults ------');
for node = 1: num_of_v
    if ~visited(node)
        cycle = dfs_find_cycle(G,node,visited);
        if ~isempty(cycle)
            %G = rmnode(G, cycle);
            display(cycle);
            for i = 1: length(cycle)
                if ~(cycle(i) == 0)
                    visited(cycle(i)) = 1;
                    achievement = achievement + weight_arr(cycle(i));
                end
            end 
            cycles = [cycles;cycle]; 
        end   
    end
end
display(visited);
display(achievement);


