% Run Script for omni-directional calibration
% Written by Qiong Wang at University of Pennsylvania
% 02/26/2014

%% Clear up
clear all;
close all;
clc;

%% Parameters
% Params
camNum = 1;
imgSz  = [480, 640];

%% Path
scriptDir = fileparts(mfilename('fullpath'));
dataDir   = '/home/qiong/ese650_data/final_project/calib_data/keyframes';
outputDir = fullfile(dataDir, '../');
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end
addpath(genpath([scriptDir, '../']));
cd('..')

%% Preprocessing
% if input('Do you want load the existing data? [Yes = 1/ No = 0] ? ')
%     % Load calibration result
%     loading_calib(outputDir);
% end
startup;        % Set the environment in Linux

%% Omni-directional Calibration
for camIdx = 1 : camNum
    % Preprocess files
%     camDir = fullfile(dataDir, ['camera', num2str(camIdx, '%02d')]);
    camDir = dataDir;

    % Read Files
    data_calib;
    
    % Extract Corners
    click_calib;
    
    % Calibration
    go_calib_optim;
    return;
    % Calibration Refinement
    ext_calib;
    
    % Reproject on images
    reproject_calib;
    
    % Show Extrinsic
    create_simulation_points(calib_data);
    
    % Analyse error
    analyse_error(calib_data);
    
    % Recomp. corners
    recomp_corner_calib(calib_data);
    
    % Show calib results
    show_calib_results(calib_data);
    
    % Save
    saving_calib(calib_data, outputDir);
        
    % Export Data
    exportData2TXT(calib_data, outputDir);
    
    % Undistort
    undistort_ocam(scriptDir, dataDir, outputDir);
end