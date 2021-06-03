clc
clear all
close all
%%
simulinkModel = "untitled";
t = 10;
generations = 100;
population = 20;
initDepth = 5;
simFunct = "simFunct";
opts = ["MaxSize", 50, "MutationLoops", 10, "MutationDepth", 8,...
    "NumberMax", 10, "NumberDelims", 0.5, "OperatorSeed", 0.5,...
    "EndNodeSeed", 0.5, ...
    "StatexSeed", 0.25, "StatexdotSeed", 0.25, "StatethetaSeed", 0.25,...
    "ElitismNumber", 1, "CrossoverNumber", 8, "ReplicationNumber", 1];
endCond = 0;

for i = 1: population
    treeList(i) = genTree(initDepth, opts);
end
tic
for i = 1:generations
    treeRes = zeros(size(treeList,2),1);
    for  j = 1:population
        err = 0;
        str = parseTree(treeList(j), simFunct);
        %timre = timer('TimerFcn', 'err = 1; set_param(simulinkModel,''SimulationCommand'',''stop'')',...
        %    'StartDelay',60);
        try
            %start(timre);
            simOut = sim(simulinkModel, t);
            %         simOut = sim(simulinkModel, simTime);
            treeRes(j) = feval(costFunction, simOut);
        catch
            fprintf("ERROR: Setting cost to inf\n");
            treeRes(j) = inf;
        end
        %stop(timre);
        %delete(timre);
        if err ~= 0
            treeRes(j) = inf;
        end
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
totalTimeOut = toc;

%%
t = 10;
parseTree(result, simFunct);
simOut = sim(simulinkModel, t);
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
sgtitle('Genetic Algorithm Results at $$\frac{\pi}{10}$$','interpreter','latex')
% xlabel ('Time')
% ylabel ('Magnitude')
% legend ({'Position', 'Velocity', 'Angle', 'Angular Velocity', 'Actuator Effort'}, 'Location', 'Best')
% legend ({'Position', 'Velocity', 'Angle', 'Angular Velocity', 'Actuator Effort'}, 'Location', 'Best') 


%%
t = 10;
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

sgtitle('Genetic Algorithm Results at $$\frac{\pi}{4}$$','interpreter','latex')



%%
save('test2', 'result', 'opts', 'population', 'generations', 'initDepth', 'simulinkModel')
parseTree(result, "ResultsV2");
