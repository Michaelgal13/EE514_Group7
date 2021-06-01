clc
clear all
close all
%%
simulinkModel = "untitled.slx";
simTime = 5;
simFunct = "simFunct";
costFunction = "costFunction";
generations = 20;
population = 5;
initDepth = 5;
opts = ["MaxSize", 30, "MutationLoops", 2, "MutationDepth", 8,...
    "NumberMax", 10, "NumberDelims", 0.5, "OperatorSeed", 0.5,...
    "EndNodeSeed", 0.5, ...
    "StatexSeed", 0.25, "StatexdotSeed", 0.25, "StatethetaSeed", 0.25,...
    "ElitismNumber", 1, "CrossoverNumber", 1, "ReplicationNumber", 1];


for i = 1: population
    treeList(i) = genTree(initDepth, opts);
end

for i = 1:generations
    treeRes = zeros(size(treeList,2),1);
    for  j = 1:population
        try
        simOut = sim(simulinkModel, simTime);
        treeRes(j) = feval(costFunction, simOut);
        catch
        fprintf("ERROR: Setting cost to inf\n");
        treeRes(j) = inf;
        end
        %str = parseTree(treeList(j), simFunct);
        %simOut = sim(simulinkModel, simTime);
        treeRes(j) = costFunction(simOut);
        fprintf("Currently: %d out of %d\n", (i-1)*population + j, (generations)*population);
    end
    treeList = evolveGen(treeList, treeRes, opts);
    population = size(treeList,2);
end

[~,I] = min(treeRes);
result = treeList(I);


%%
parseTree(result, simFunct);
simOut = sim(simulinkModel, simTime);
y = simOut.yout(1)^2;