clc;
close all;
clear all;
nT = [2 2 2];
nR = [2 2 2];
H = GenerateChannel(nT,nR,1);
answer = ClosedForm3Users(H);