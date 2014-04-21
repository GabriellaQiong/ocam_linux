% Run Script for omni-directional calibration
% Written by Qiong Wang at University of Pennsylvania
% 02/26/2014

%% Clear up
clear all;
close all;
clc;

%% Parameters
% Params
imgSz  = [480, 640];

%% Path
dataset   = 'minion';
scriptDir = fileparts(mfilename('fullpath'));
calibDir  = '/home/qiong/ese650_data/final_project/results';
dataDir   = fullfile('/home/qiong/Dropbox/Spring2014/ese650/Projects/SFM/data', dataset);
outputDir = fullfile(dataDir, ['../rect/rect_', dataset]);
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end
addpath(genpath(scriptDir));

%% Preprocessing
% Load calibration result
startup;                                    % Set the environment in Linux
verStr = version;
if strcmp(verStr(end - 6 :  end - 1), 'R2014a')
    load(fullfile(calibDir, 'calib_result.mat'));
    if ~exist(fullfile(calibDir, 'calib_result13.mat'), 'file')
        radialDist = calib_result.RadialDistortion;
        tangDist   = calib_result.TangentialDistortion;
        corners    = calib_result.WorldPoints;
        unit       = calib_result.WorldUnits;
        estSkew    = calib_result.EstimateSkew;
        coefNum    = calib_result.NumRadialDistortionCoefficients;
        estTanDist = calib_result.EstimateTangentialDistortion;
        tranVec    = calib_result.TranslationVectors;
        reprojErr  = calib_result.ReprojectionErrors;
        numPattern = calib_result.NumPatterns;
        intrinMat  = calib_result.IntrinsicMatrix;
        meanErr    = calib_result.MeanReprojectionError;
        rotMat     = calib_result.RotationMatrices;
        save(fullfile(calibDir, 'calib_result13.mat'), 'radialDist', 'tangDist'...
            , 'corners', 'unit', 'estSkew', 'coefNum', 'estTanDist', 'tranVec'...
            , 'reprojErr', 'numPattern', 'intrinMat', 'meanErr', 'rotMat');
    end
else
    load(fullfile(calibDir, 'calib_result13.mat'));
end

% Undistortion
dirImg  = dir(dataDir);
imgName = {dirImg(:).name}';
imgName(ismember(imgName,{'.','..'})) = [];
numImgs = length(imgName);

if strcmp(verStr(end - 6 : end - 1), 'R2014a')
    for imgIdx = 1 : numImgs
        fprintf('Processing frame #%d ...\n', imgIdx);
        I = imresize(imread(fullfile(dataDir, char(imgName(imgIdx)))), imgSz);
        J = undistortImage(I, calib_result);
        imwrite(J, fullfile(outputDir, sprintf('%s_%03d_rect.jpg', dataset, imgIdx)));
    end
else
    k            = radialDist;
    p            = tangDist;    
    distCoeffs   = [k(1), k(2), p(1), p(2), k(3)];
    cameraMatrix = intrinMat';
    for imgIdx = 1 : numImgs
        fprintf('Processing frame #%d ...\n', imgIdx);
        src = imresize(imread(fullfile(dataDir, char(imgName(imgIdx)))), imgSz);
        dst = cv.undistort(src, cameraMatrix, distCoeffs);
        imwrite(dst, fullfile(outputDir, sprintf('%s_%03d_rect.jpg', dataset, imgIdx)));
    end
end