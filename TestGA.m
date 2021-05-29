clc
clear all
close all
%%
simulinkModel = "SimulinkFblock.slx";
simTime = 5;
simFunct = "simFunct.m";
generations = 5;

simOut = sim(simulinkModel, simTime);
yval = simOut.yout(1);