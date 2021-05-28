%%
function treeOut = genTree(depth, opts)
if isempty(opts)
    endNodeSeed = 0.5;
    operatorSeed = 0.5;
else
    endNodeSeed = opts(1);
    operatorSeed = opts(2);
end
if depth <= 0
    treeOut = 0;
elseif depth == 1
    treeOut = tree(randEndNode(endNodeSeed));
else
    treeOut = tree(randOperator(operatorSeed));
    for i = 2:2^(depth- 1)-1
        treeOut = treeOut.addnode(floor(i/2),randOperator(operatorSeed));
    end
    for i = 2^(depth - 1) : 2^(depth)-1
        treeOut = treeOut.addnode(floor(i/2),randEndNode(endNodeSeed));
    end  
end
end
