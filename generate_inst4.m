s = [1 1 2 2 3 3 4 5 6 7 8 9 5  10 11 8  12 13 12 14 15 13];
t = [2 4 3 5 1 6 7 8 9 1 2 3 10 11 5  12 13 8  14 15 12 16];

nv = max(s);
child = [0 1 2 11 13 14];
child = sort(child);
G = digraph(s,t);
A = adjacency(G);
plot(G)

fileID = fopen('team.in','w');
fprintf(fileID,'%d\n',nv);
for childID = 1:length(child)-1
    fprintf(fileID,'%d ',child(childID));
end
fprintf(fileID,'%d',child(childID+1));
fprintf(fileID,'\n');

adj = zeros(nv);
for eID = 1:length(s)
    adj(s(eID),t(eID)) = 1;
end

for rowID = 1:nv
    for colID = 1:nv-1
        fprintf(fileID, '%d ', adj(rowID, colID));
    end
    fprintf(fileID, '%d\n', adj(rowID, colID));
end

