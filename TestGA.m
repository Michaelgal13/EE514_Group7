clc
clear all
close all
%%
simulinkModel = "untitled.slx";
simTime = 5;
simFunct = "simFunct";
costFunction = "costFunction";
generations = 40;
population = 10;
initDepth = 5;
opts = ["MaxSize", 30, "MutationLoops", 2, "MutationDepth", 8,...
    "NumberMax", 10, "NumberDelims", 0.5, "OperatorSeed", 0.5,...
    "EndNodeSeed", 0.5, ...
    "StatexSeed", 0.25, "StatexdotSeed", 0.25, "StatethetaSeed", 0.25,...
    "ElitismNumber", 1, "CrossoverNumber", 1, "ReplicationNumber", 1];
endCond = 1;

for i = 1: population
    treeList(i) = genTree(initDepth, opts);
end

for i = 1:generations
    treeRes = zeros(size(treeList,2),1);
    for  j = 1:population
        str = parseTree(treeList(j), simFunct);
        try
        simOut = sim(simulinkModel, simTime);
        treeRes(j) = feval(costFunction, simOut);
        catch
        fprintf("ERROR: Setting cost to inf\n");
        treeRes(j) = inf;
        end
        fprintf("Currently: %d out of %d\n", (i-1)*population + j, (generations)*population); 
    end
%     treeRes = sort(treeRes);
%     for  j = 1:population
%     genRes(i,j) = (treeRes(j));
%     end
%     plot(1:i,genRes(:,1));
%     hold on
%     for j = 2: population
%         plot(1:i, genRes(:,j));
%     end
%     hold off
    genRes(i) = min(treeRes);
    plot(1:i,genRes);
    xlim([1 generations]);
    xlabel("Generations");
    ylabel("Minimum Cost");
    drawnow;
    pause(0.01)
    if endCond == 1
        if min(treeRes) == 0
            fprintf("End Condition Occured on generation %d\n", i);
            break;
        end
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
