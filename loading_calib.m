function loading_calib(outputDir)
% Editted by Qiong Wang at University of Pennsylvania
% 04/19/2014

fileString = fullfile(outputDir, 'Omni_Calib_Results.mat');
if ~exist(fileString, 'file')
   fprintf(1,'\nCalibration file Omni_Calib_Results.mat not found!\n');
   return;
end;

fprintf(1,'\nLoading calibration results from Omni_Calib_Results.mat\n');

clear calib_data;
load(fileString);

fprintf(1,'done\n');
end