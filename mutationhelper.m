function endTree = mutationhelper(tree, seed,maxSize, opts)
if isempty(opts) 
loops = 1;
else
    loops = opts(1);
end
for i = 1: loops
    val = cast(rand * tree.nnodes() + 1, 'int32');
    if val > tree.nnodes()
        val = tree.nnodes();
    elseif val <= 0
        val = 1;
    end
    
    deep1 = depth(tree);
    deep2 = depth(tree.subtree(val));
    newDeep2 = rand * 1/seed;
    if newDeep2 < 1
        newDeep2 = 1;
    elseif (deep1-deep2)+newDeep2 > maxSize
        newDeep2 = maxSize - (deep1-deep2);
    end
    newTree = genTree(newDeep2, []);
    par = tree.Parent(val);
    if par == 0
        tree = newTree;
    else
        tree=tree.chop(val);
        tree = tree.graft(par, newTree);
    end
    endTree = tree;
end


end
