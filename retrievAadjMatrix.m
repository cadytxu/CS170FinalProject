fid = fopen('1.in', 'r');
num_v = fgetl(fid);
children = fgetl(fid);
Nrow_original = str2num(num_v);
Ncol_original = str2num(num_v);

Identity_matrix = eye(Nrow_original)* -1;
M = dlmread('1.in');
M(1:2,:) = [];
M_transpose = M.';

new_M = zeros(2 * num_v, num_v^2 + num_v, 'uint8');

fclose(fid);
