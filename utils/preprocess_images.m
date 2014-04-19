function preprocess_images(camDir, sz)
% Written by Qiong Wang at University of Pennsylvania
% 04/18/2014

dirCam  = dir(camDir);
imgName = {dirCam(:).name}';
imgName(ismember(imgName,{'.','..'})) = [];
numImgs = length(imgName);
temp    = fullfile(camDir, 'temp.jpg');

if numImgs == str2double(imgName{end}(7 : end - 4))
    return;
end

for imgIdx = 1 : numImgs
    fprintf('Processing frame #%d ...\n', imgIdx);
    movefile(fullfile(camDir, char(imgName(imgIdx))), temp);
    img = imresize(imread(temp), sz);
    imwrite(img, fullfile(camDir, sprintf('calib_%03d.jpg', imgIdx)));
    delete(temp);
end

end