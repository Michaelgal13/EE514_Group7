function endTree = mutationhelper(tree, opts)
if isempty(opts) || (size(opts,2) < 2)
    loops = 1;
    mutDepth = 4;
    maxSize = inf;
else
    %loops = opts(1);'
    a = find(opts(:) == "MutationLoops");
    if isempty(a)
        loops = 1;
    else
        loops = opts(a(1)+1);
        loops = str2double(loops);
    end
    a = find(opts(:) == "MutationDepth");
    if isempty(a)
        mutDepth = 4;
    else
        mutDepth = opts(a(1)+1);
        mutDepth = str2double(mutDepth);
    end
    a = find(opts(:) == "MaxSize");
    if isempty(a)
        maxSize = inf;
    else
        maxSize = opts(a(1)+1);
        maxSize = str2double(maxSize);
    end
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
    newDeep2 = rand * mutDepth;
    if newDeep2 < 1
        newDeep2 = 1;
    elseif (deep1-deep2)+newDeep2 > maxSize
        newDeep2 = maxSize - (deep1-deep2);
    end
    newTree = genTree(newDeep2, opts);
    par = tree.Parent(val);
    if par == 0
        tree = newTree;
    else
        tree=tree.chop(val);
        tree = tree.graft(par, newTree);
    end
    % disp(tree.tostring);
end
endTree = tree;

end
