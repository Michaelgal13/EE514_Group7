%% Cross Trees
function newTree = crossTrees(tree1, tree2, opts)
if isempty(opts) || (size(opts,2) < 2)
    maxSize = inf;
else
    a = find(opts(:) == "MaxSize");
    if isempty(a)
        maxSize = inf;
    else
        maxSize = opts(a(1)+1);
        maxSize = str2double(maxSize);
    end
end


    % random select node on tree 1
    
    % cut out node of tree 1
    
    % random select node of tree 2 (limited by tree 1 node depth + )
    
    
end