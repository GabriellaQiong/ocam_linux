function undistort_ocam(scriptDir, dataDir, outputDir)
% UNDISTORT_OCAM() undistorts images
% Written by Qiong Wang at University of Pennsylvania
% 04/19/2014

cd(fullfile(scriptDir, 'undist_ocam', 'bin'));
resultDir = fullfile(outputDir, 'undistorted');
calibFile = fullfile(outputDir, 'calib_results.txt');
if ~exist(resultDir, 'dir')
    mkdir(resultDir); 
end

dirCam  = dir(dataDir);
imgName = {dirCam(:).name}';
imgName(ismember(imgName,{'.','..'})) = [];
numImgs = length(imgName);

for imgIdx = 1 : numImgs
    fprintf('Processing frame #%d ...\n', imgIdx);
    cmd = ['./main ', calibFile, ' ', fullfile(dataDir, char(imgName(imgIdx))), ...
           ' ', fullfile(resultDir, sprintf('calib_%03d.jpg', imgIdx)), ' 4 0' ];
    system(cmd);
end
cd(scriptDir);

end