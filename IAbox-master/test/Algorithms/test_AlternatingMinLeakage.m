clc;
clear;
close all;

% K = 6;              % Num users
% T = 1;
% D=diag(5*ones(K,1));          % Demands matrix
% A=ones(K);          % Fully connected system (Xnetwork)
% nT=8*ones(K,1);     % Tx antennas
% nR=26*ones(K,1);     % Rx antennas

% K = 4;              % Num users
% T = 1;
% D=diag(6*ones(K,1));          % Demands matrix
% A=ones(K);          % Fully connected system (Xnetwork)
% nT=15*ones(K,1);     % Tx antennas
% nR=15*ones(K,1);     % Rx antennas

% K = 5;              % Num users
% T = 1;
% D=diag(10*ones(K,1));          % Demands matrix
% A=ones(K);          % Fully connected system (Xnetwork)
% nT=30*ones(K,1);     % Tx antennas
% nR=30*ones(K,1);     % Rx antennas

% K = 3;              % Num users
% T = 1;
% D=diag(2*ones(K,1));          % Demands matrix
% A=ones(K);          % Fully connected system (Xnetwork)
% nT=2*ones(K,1);     % Tx antennas
% nR=6*ones(K,1);     % Rx antennas

% K = 3;              % Num users
% T = 1;
% D=diag(1*ones(K,1));          % Demands matrix
% A=ones(K);          % Fully connected system (Xnetwork)
% nT=2*ones(K,1);     % Tx antennas
% nR=2*ones(K,1);     % Rx antennas

% K = 4;              % Num users
% T = 1;
% D=diag(8*ones(K,1));          % Demands matrix
% A=ones(K);          % Fully connected system (Xnetwork)
% nT=11*ones(K,1);     % Tx antennas
% nR=29*ones(K,1);     % Rx antennas

K = 3;              % Num users
T = 1;
D=diag(3*ones(K,1));          % Demands matrix
A=ones(K);          % Fully connected system (Xnetwork)
nT=6*ones(K,1);     % Tx antennas
nR=6*ones(K,1);     % Rx antennas

% K = 3;              % Num users
% T = 1;
% D=diag(4*ones(K,1));          % Demands matrix
% A=ones(K);          % Fully connected system (Xnetwork)
% nT=10*ones(K,1);     % Tx antennas
% nR=6*ones(K,1);     % Rx antennas

% K = 19;              % Num users
% T = 1;
% D=diag(1*ones(K,1));          % Demands matrix
% A=ones(K);          % Fully connected system (Xnetwork)
% nT=10*ones(K,1);     % Tx antennas
% nR=10*ones(K,1);     % Rx antennas

% K = 3;              % Num users
% T = 1;
% D=diag([3 3 3]);          % Demands matrix
% A=ones(K);          % Fully connected system (Xnetwork)
% nT=4*ones(K,1);     % Tx antennas
% nR=8*ones(K,1);     % Rx antennas

K = 4;              % Num users
T = 1;
D=diag(2*ones(K,1));          % Demands matrix
A=ones(K);          % Fully connected system (Xnetwork)
nT=5*ones(K,1);     % Tx antennas
nR=5*ones(K,1);     % Rx antennas

% K = 5;              % Num users
% T = 1;
% D=diag(1*ones(K,1));          % Demands matrix
% A=ones(K);          % Fully connected system (Xnetwork)
% nT=3*ones(K,1);     % Tx antennas
% nR=3*ones(K,1);     % Rx antennas

% K = 3;              % Num users
% T = 5;              % Time extensions
% D=diag(4*ones(K,1));  % Demands matrix
% A=ones(K);          % Fully connected system (Xnetwork)
% nT=1*ones(K,1);     % Tx antennas
% nR=1*ones(K,1);     % Rx antennas
%
% K = 4;              % Num users
% T = 3;              % Time extensions
% D=diag([2 2 2 2]);  % Demands matrix
% A=ones(K);          % Fully connected system (Xnetwork)
% nT=1*ones(K,1);     % Tx antennas
% nR=1*ones(K,1);     % Rx antennas

K=5;
nT=12*ones(K,1);
nR=12*ones(K,1);
A=ones(K);
D=diag(4*ones(K,1));

%% Simulation parameters
SNR_dB=20;

%%
options.NumExtensions=T;
options.ACS=false;
options.ConstantExtensions=true;
options.A=A;
H = GenerateChannel(nT,nR,options);
[U0,V0] = RandomBeamforming(H,D);

options.Verbose=0;
options.StartingPoint.U=U0;
options.StartingPoint.V=V0;
options.MaxIter=5000;
options.Tol=1e-3;

%% Run the algorithm
tic;
[U, V, IL]=AlternatingMinLeakage(H,D,options);
t=toc;
fprintf('Elapsed time: %.2f, Interference leakage: %.2e\n',t,IL(end));

%% Plot convergence curve
semilogy(0:length(IL)-1,IL,'b');
grid on;
xlabel('Iteration number');
ylabel('Interference leakage');
title('Interference leakage evolution with the number of iterations');
