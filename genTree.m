%%
function treeOut = genTree(depth, opts)
endNodeSeed = 0.5;
operatorSeed = 0.5;
% if isempty(opts)
%     endNodeSeed = 0.5;
%     operatorSeed = 0.5;
% else
%     endNodeSeed = opts(1);
%     operatorSeed = opts(2);
% end
if depth <= 0
    treeOut = 0;
elseif depth == 1
    treeOut = tree(randEndNode(opts));
else
    treeOut = tree(randOperator(opts));
    for i = 2:2^(depth- 1)-1
        treeOut = treeOut.addnode(floor(i/2),randOperator(opts));
    end
    for i = 2^(depth - 1) : 2^(depth)-1
        treeOut = treeOut.addnode(floor(i/2),randEndNode(opts));
    end  
end
end
