clc
clear all
close all
%%
simulinkModel = "untitled.slx";
simTime = 10;
t = [0:simTime/1e4:simTime];
simFunct = "simFunct";
costFunction = "costFunction";
generations = 10;
population = 5;
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
        simOut = sim(simulinkModel, t);
%         simOut = sim(simulinkModel, simTime);
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
simOut = sim(simulinkModel, t);
% simOut = sim(simulinkModel, simTime);
y = feval(costFunction, simOut);

figure(101)
subplot(2,3,1)
plot (t,simOut.xnew.Data(:,1)')
xlabel ('Time')
ylabel ('Position')
subplot(2,3,2)
plot (t,simOut.xnew.Data(:,2)')
xlabel ('Time')
ylabel ('Velocity')
subplot(2,3,3)
plot (t,simOut.xnew.Data(:,3)')
xlabel ('Time')
ylabel ('Angle')
subplot(2,3,4)
plot (t,simOut.xnew.Data(:,4)')
xlabel ('Time')
ylabel ('Angular Velocity')
subplot(2,3,5)
plot (t,simOut.yout)
xlabel ('Time')
ylabel ('Acutator Effort')
% xlabel ('Time')
% ylabel ('Magnitude')
% legend ({'Position', 'Velocity', 'Angle', 'Angular Velocity', 'Actuator Effort'}, 'Location', 'Best') 