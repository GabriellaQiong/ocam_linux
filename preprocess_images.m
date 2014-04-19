function preprocess_images(camDir, sz)
% Written by Qiong Wang at University of Pennsylvania
% 04/18/2014

dirCam  = dir(camDir);
imgName = {dirCam(:).name}';
imgName(ismember(imgName,{'.','..'})) = [];
numImgs = length(imgName);

for imgIdx = 1 : numImgs
    fprintf('Processing frame #%d ...\n', imgIdx);
    img = imresize(imread(fullfile(camDir, char(imgName(imgIdx)))), sz);
    imwrite(img, fullfile(camDir, sprintf('calib_%03d.jpg', imgIdx)));
    delete(fullfile(camDir, char(imgName(imgIdx))));
end

end