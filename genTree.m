%%
function treeOut = genTree(depth)
if depth <= 1
    treeOut = 0;
else
    treeOut = tree(randOperator(0.5));
    for i = 2:2^(depth)-1
        floor(i/2)
        treeOut = treeOut.addnode(floor(i/2),randOperator(0.5));
    end
    for i = 2^(depth) : 2^(depth + 1)-1
        treeOut = treeOut.addnode(floor(i/2),randEndNode(0.5));
    end  
end
end
