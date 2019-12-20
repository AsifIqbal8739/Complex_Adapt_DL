% Simulation script 1 for Complex TC and SM recovery
% Author: Asif Iqbal 10 Oct 2018
%%
clc; clear all; close all;
addpath 'C:\Google Drive\MATLAB\Paper Implementations\Complex_fMRI_Practice\CDL_COde';

%% Data Setup
% simulate_complex_fmri_sources;
load 'Complex_Data.mat';    % GT
% Disp_Act(W,S);
nS = size(cS,1);
SnRdB = 5;
K = 15;                 %nAtoms

%% Noise addition
Yn = awgn(real(cX),SnRdB,'measured') + 1j*awgn(imag(cX),SnRdB,'measured');

%% Running for CDL
nT = size(cX,1);
DC = normc_Comp(randn(nT,K)+1j*randn(nT,K));
lambda = 7; % regularization (shrinkage) parameter to tune
noIt = 25;
[D_Conv,E_ConvN,E_ConvG,D,X] = Complex_DL(Yn,DC,1,lambda,cX,noIt,1);
[DPC,XPC,XMask] = SM_Phase(D,X,1,pi/18,0);

Disp_Act_Comp(abs(DPC),abs(XPC));

