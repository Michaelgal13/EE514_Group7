clc
clear
x = 1;
xdot = 2;
theta = 1;
thetadot = 2;


tree = genTree(5, []);
tree = mutationhelper(tree, ["MaxSize", 20, "MutationLoops", 2, "MutationDepth", 8]);
disp(tree.tostring);
%outPut = parseTree(tree);


k = feval(outPut, x, xdot, theta,thetadot);


