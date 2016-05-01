%extract adjacency matrix and transpose of adjacency matrix
fid = fopen('196.in', 'r');
num_v = fgetl(fid);
num_v = str2num(num_v);
children = str2num(fgetl(fid));

Nrow_original = num_v;
Ncol_original = num_v;

Identity_matrix = eye(Nrow_original)* -1;
M = dlmread('196.in');
M(1:2,:) = [];
M_transpose = M.';

G = digraph(M);
plot(G);


%form Aeq
new_M = zeros(num_v, num_v^2, 'double');
for i = 1:num_v
    start_i = (i - 1)*num_v + 1;
    end_i = i*num_v;
    new_M(i, start_i : end_i) = M(i,:);
end

new_M = [new_M Identity_matrix];

new_M_transpose = zeros(num_v, num_v^2, 'double');
for i = 1:num_v
    start_i = (i - 1)*num_v + 1;
    end_i = i*num_v;
    new_M_transpose(i, start_i:end_i) = M_transpose(i,:);
end
new_M_transpose = [new_M_transpose Identity_matrix];

Aeq = [new_M; new_M_transpose];

%form beq
beq = zeros(num_v * 2, 1, 'double');

%form upper bound and lower bound for x
lb = zeros(num_v^2 + num_v,1,'double');
ub = ones(num_v^2 + num_v,1,'double');

%form f
M_transpose_weight = M_transpose * -1;
for i = children
    children_row = M_transpose_weight(i,:);
    children_row(children_row == -1) = -2;
    M_transpose_weight(i,:) = children_row;
end

f = reshape(M_transpose_weight,1, num_v*num_v); 
num_v_zeros = zeros(1, num_v, 'double');
f = horzcat(f, num_v_zeros);

intcon = 1:num_v*num_v+num_v;

x = intlinprog(f, intcon, [], [], Aeq, beq, lb, ub);

fclose(fid);
