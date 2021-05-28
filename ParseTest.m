clc
clear
x = 1;
xdot = 2;
theta = 1;
thetadot = 2;
opts = ["MaxSize", 20, "MutationLoops", 2, "MutationDepth", 8,...
    "NumberMax", 10, "NumberDelims", 0.5, "OperatorSeed", 0.5,...
    "EndNodeSeed", 0.5, ...
    "StatexSeed", 0.25, "StatexdotSeed", 0.25, "StatethetaSeed", 0.25];

tree = genTree(5, opts);
tree = mutationhelper(tree, opts);
disp(tree.tostring);
outPut = parseTree(tree);


k = feval(outPut, x, xdot, theta,thetadot);


