s = [1 2 3 4 5 6 7 8 9 10];
t = [2 3 4 5 6 7 1 9 10 8];

nv = max(s);
child = [1 2];
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

