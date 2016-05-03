function [ cycles ] = greedy_find_cycles(num_of_v, children, adj_matrix)
%GREEDY_CYCLES Summary of this function goes here
%   Detailed explanation goes here

%fid = fopen('UNBREAKABLE2.in', 'r');
%fid = fopen('phase1-processed/196.in', 'r');
%num_of_v_str = fgetl(fid);
%num_of_v = str2num(num_of_v_str);
%display(num_of_v);

%children = strread(fgetl(fid));
num_of_children = length(children);
%display(num_of_children);

%adj_matrix = dlmread('UNBREAKABLE2.in');
%adj_matrix = dlmread('phase1-processed/196.in');

%adj_matrix(1:2,:) = [];
%M_transpose = M.';
G = digraph(adj_matrix); 
%plot(G); 
%figure
%fclose(fid);

visited = zeros(1, num_of_v); 
weight_arr = ones(1, num_of_v);
for v = 1:num_of_children
    weight_arr(children(v)+1) = 2;
end 
    
cycles = [];
achievement = 0; 
cycle = [];


%display('children ------');
for i = 1: num_of_children
    child = children(i);
    %display(child);
    if ~visited(child)
        cycle = bfs_find_cycle(G,child,visited);
        %display(cycle);
        if isempty(cycle) 
            %visited(i) = 1; 
        else 
            %G = rmnode(G, cycle);
            %display(cycle);
            for j = 1: length(cycle)
                if cycle(j) ~= 0
                    visited(cycle(j)) = 1;
                    achievement = achievement + weight_arr(cycle(j));
                end
            end 
            cycles = [cycles;cycle]; 
        end   
    end
end

%display('adults ------');
for node = 1: num_of_v
    if ~visited(node)
        %display(node);
        cycle = bfs_find_cycle(G,node,visited);
        if isempty(cycle)
            %visited(node) = 1; 
        else 
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
%display(visited);
display(achievement);

A = zeros(num_of_v, num_of_v);

for row = 1:size(cycles, 1)
    col = 1;
    while col < 5 && cycles(row, col+1) ~=0
        A(cycles(row, col), cycles(row, col+1)) = 1;
        col = col + 1;
    end
    A(cycles(row, col), cycles(row, 1)) = 1;
end 
G_solution = digraph(A); 
%plot(G_solution); 

