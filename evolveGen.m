function treeList = evolveGen(trees, costs, opts)
population = size(trees,2);
%checks for options
if isempty(opts) || (size(opts,2) < 2)
    elite = 1;
    repNum  = 0;
    xOver = floor(population / 2);
else
    %number of mutations per cycle
    a = find(opts(:) == "ElitismNumber");
    if isempty(a)
        elite = 1;
    else
        elite = opts(a(1)+1);
        elite = str2double(elite);
    end
    % maximum size of generated tree
    a = find(opts(:) == "CrossoverNumber");
    if isempty(a)
        xOver = floor(population / 2);
    else
        xOver = opts(a(1)+1);
        xOver = str2double(xOver);
    end
    % maximum size allowed
    a = find(opts(:) == "ReplicationNumber");
    if isempty(a)
        repNum = 0;
    else
        repNum = opts(a(1)+1);
        repNum = str2double(repNum);
    end
end
mutNum = population - elite - xOver - repNum;
if mutNum < 0
    mutNum = 0;
end

for i = 1:population
    for j = 1:population
    [~,I] = min(costs);
    sortList(i) = trees(I);
    costs(I) = inf;
    end
end
for i = 1: elite
    treeList(i) = sortList(i);
end
for i = 1:repNum
    b = floor(rand * (population + 1));
    if b < 1
        b = 1;
    elseif b > population
        b = population;
    end
    treeList(i+elite) = trees(b);
end
for i = 1:xOver
    b = floor(rand * (population + 1));
    if b < 1
        b = 1;
    elseif b > population
        b = population;
    end
    c = floor(rand * (population + 1));
    if c < 1
        c = 1;
    elseif c > population
        c = population;
    end
    while c == b
        c = floor(rand * (population + 1));
        if c < 1
            c = 1;
        elseif c > population
            c = population;
        end
    end
    [newTree1, newTree2] = crossTrees(trees(b), trees(c), opts);
    treeList(i+elite+repNum) = newTree1;
    if i + 1<= xOver
        i = i+1;
        treeList(i+elite+repNum) = newTree2;
    end
end
for i = 1:mutNum
    b = floor(rand * (population + 1));
    if b < 1
        b = 1;
    elseif b > population
        b = population;
    end
    treeList(i+elite+repNum+xOver) = mutationhelper(trees(b), opts);
end    


end