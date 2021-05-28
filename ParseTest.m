clc
clear
x = 1;
xdot = 2;
theta = 1;
thetadot = 2;


tree = genTree(5, []);
tree = mutationhelper(tree, 0.25, 20, 3);
disp(tree.tostring);
outPut = parseTree(tree);




