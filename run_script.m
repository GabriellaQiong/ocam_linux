% Run Script for rearrangin files
% Written by Qiong Wang at University of Pennsylvania
% 02/26/2014

%% Clear up
clear all;
close all;
clc;

%% Parameters
verbose  = false;                             % Whether to show the details

%% Path
scriptDir = fileparts(mfilename('fullpath'));
dataDir   = '/media/Gabriella/GoPro-20140217-calib_data/images/';
calibDir  = '/media/Gabriella/GoPro-20140217-calib_data/results/';
if ~exist(calibDir, 'dir')
    mkdir(calibDir);
end
addpath(genpath(scriptDir));

%% 