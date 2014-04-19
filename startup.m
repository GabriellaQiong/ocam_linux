% Start_up script to set the environment
% Written by Qiong Wang at University of Pennsylvania
% Feb.26th, 2014

original_path = getenv('LD_LIBRARY_PATH');
opencv_path   = '/usr/local/lib/';
new_path      = [opencv_path,':', original_path];
setenv('LD_LIBRARY_PATH', new_path);

files = strread(genpath(fileparts(mfilename('fullpath'))),'%s','delimiter',':'); %#ok<FPARK>
for i = 1 : numel(files)
    files{i} = [files{i}, '/*~'];
end
cellfun(@delete, files);