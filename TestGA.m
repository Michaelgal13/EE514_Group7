% clc
clear all
close all
%%
simulinkModel = "untitled_pi4.slx";
simTime = 10;
t = [0:simTime*1e-4:simTime];
simFunct = "simFunct";
costFunction = "costFunction";
generations = 20;
population = 10;
initDepth = 5;
opts = ["MaxSize", 30, "MutationLoops", 5, "MutationDepth", 8,...
    "NumberMax", 10, "NumberDelims", 0.5, "OperatorSeed", 0.5,...
    "EndNodeSeed", 0.5, ...
    "StatexSeed", 0.25, "StatexdotSeed", 0.25, "StatethetaSeed", 0.25,...
    "ElitismNumber", 1, "CrossoverNumber", 3, "ReplicationNumber", 1];
endCond = 1;

for i = 1: population
    treeList(i) = genTree(initDepth, opts);
end

for i = 1:generations
    treeRes = zeros(size(treeList,2),1);
    for  j = 1:population
        str = parseTree(treeList(j), simFunct);
        timre = timer('TimerFcn', 'set_param(''untitled_pi4'',''SimulationCommand'',''stop'')',... % strcat(' error(''TIMEOUT',string(j),'!'');'),
            'StartDelay',10);
%         timre = timer('TimerFcn', ' error(''TIMEOUT!'');',...
%             'StartDelay',10);
        try
        start(timre);
        simOut = sim(simulinkModel, t);
        stop(timre);
        if simOut.tout(end) ~= simTime
            fprintf("TIMEOUT: sim stoped at %d seconds\n", simOut.tout(end));
            ME = MException('VerifyOutput:OutOfBounds', ...
             'Results are outside the allowable limits');
            throw(ME);
        end
%         simOut = sim(simulinkModel, simTime);
        treeRes(j) = feval(costFunction, simOut);
        catch
        fprintf("ERROR: Setting cost to inf\n");
        treeRes(j) = inf;
        end
        delete(timre);
        fprintf("Currently: %d out of %d at %s\n", (i-1)*population + j, (generations)*population, datestr(now,'HH:MM:SS.FFF'));
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
%     ylim([0 1]);
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
simOut = sim('untitled.slx', t);
% simOut = sim(simulinkModel, simTime);
y = feval(costFunction, simOut);

figure(101)
subplot(2,3,1)
% plot (t,simOut.xnew.Data(:,1)')
plot (simOut.tout,simOut.xnew.Data(:,1)')
xlabel ('Time')
ylabel ('Position')
subplot(2,3,2)
% plot (t,simOut.xnew.Data(:,2)')
plot (simOut.tout,simOut.xnew.Data(:,2)')
xlabel ('Time')
ylabel ('Velocity')
subplot(2,3,3)
% plot (t,simOut.xnew.Data(:,3)')
plot (simOut.tout,simOut.xnew.Data(:,3)')
xlabel ('Time')
ylabel ('Angle')
subplot(2,3,4)
% plot (t,simOut.xnew.Data(:,4)')
plot (simOut.tout,simOut.xnew.Data(:,4)')
xlabel ('Time')
ylabel ('Angular Velocity')
subplot(2,3,5)
% plot (t,simOut.yout)
plot (simOut.tout,simOut.yout)
xlabel ('Time')
ylabel ('Acutator Effort')
% xlabel ('Time')
% ylabel ('Magnitude')
% legend ({'Position', 'Velocity', 'Angle', 'Angular Velocity', 'Actuator Effort'}, 'Location', 'Best') 


%%
parseTree(result, simFunct);
simOut = sim("untitled_pi4.slx", t);
% simOut = sim(simulinkModel, simTime);
y = feval(costFunction, simOut);

figure(201)
subplot(2,3,1)
% plot (t,simOut.xnew.Data(:,1)')
plot (simOut.tout,simOut.xnew.Data(:,1)')
xlabel ('Time')
ylabel ('Position')
subplot(2,3,2)
% plot (t,simOut.xnew.Data(:,2)')
plot (simOut.tout,simOut.xnew.Data(:,2)')
xlabel ('Time')
ylabel ('Velocity')
subplot(2,3,3)
% plot (t,simOut.xnew.Data(:,3)')
plot (simOut.tout,simOut.xnew.Data(:,3)')
xlabel ('Time')
ylabel ('Angle')
subplot(2,3,4)
% plot (t,simOut.xnew.Data(:,4)')
plot (simOut.tout,simOut.xnew.Data(:,4)')
xlabel ('Time')
ylabel ('Angular Velocity')
subplot(2,3,5)
% plot (t,simOut.yout)
plot (simOut.tout,simOut.yout)
xlabel ('Time')
ylabel ('Acutator Effort')




%%
% save('test2', 'result', 'opts', 'population', 'generations', 'initDepth', 'simulinkModel')