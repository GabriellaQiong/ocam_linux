% Run Script for rearrangin files
% Written by Qiong Wang at University of Pennsylvania
% 02/26/2014

%% Clear up
clear all;
close all;
clc;

%% Parameters
% Flags
verbose  = false;                             % Whether to show the details

% Params
camNum = 1;
imgSz  = [480, 640];

%% Path
scriptDir = fileparts(mfilename('fullpath'));
dataDir   = '/home/qiong/ese650_data/final_project/calib_data/';
outputDir = fullfile(dataDir, '../results');
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end
addpath(genpath(scriptDir));

%% Preprocessing
start_up;        % Set the environment in Linux
set_up_global;   % Prepare workspace variables

%% Omni-directional Calibration
for camIdx = 1 : camNum
    % Read Files
%     camDir = fullfile(dataDir, ['camera', num2str(camIdx, '%02d')]);
    camDir = dataDir;
%     preprocess_images(camDir, imgSz);
    data_calib(calib_data, camIdx, camDir);
    
%     % Extract Corners
%     click_calib(calib_data, imgSz);
%     
%     % Calibration
%     calibration(calib_data);
%     
%     % Find center
%     findcenter(calib_data);
%     
%     % Calibration Refinement
%     calibration(calib_data);
end