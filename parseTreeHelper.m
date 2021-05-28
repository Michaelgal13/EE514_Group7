function outVal = parseTreeHelper(tree)
if isleaf(tree,1)
    outVal = string(tree.Node(1));
    return
else
    curVal = string(tree.Node(1));
    if curVal == "&+"
        curString = "plus(";
    elseif curVal == "&*"
        curString = "times(";
    else
        curString = "error(";
    end
    children = getchildren(tree,1);
    curVal = strcat(curString, parseTreeHelper(tree.subtree(children(1))), ",", parseTreeHelper(tree.subtree(children(2))),")");
    outVal = curVal;
end