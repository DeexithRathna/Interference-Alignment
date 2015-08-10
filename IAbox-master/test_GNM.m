clc;
close all;
clear all;

%   Solve the (5x5,2)^4 system:
         K = 4; %Number of users
      D = diag(2*ones(K,1));
      nT = 5; %Number of transmit antennas
      nR = 5; %Number of receive antennas
      H = cell(K,K); %Channel's cell array
      for rx = 1:K
           for tx = 1:K
               H{rx,tx}=crandn(nR,nT); %Random channel
           end
      end
      [U,V,I, success] = GaussNewtonMinLeakage(H,D);