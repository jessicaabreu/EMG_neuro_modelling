% Script to get blocks that have EMG data per day
%
% Creates a structure that stores EMG recordings and stimulation parameters
% according to: 
% day.blocks.sub_blocks.EMGdata
% day.blocks.sub_blocks.StimParams
%
% Expected folder structure:
% root folder
% => folders_per_day
% ==> LogData files
%
% LogData is a file that stores all stimulation parameteres and potentially
% EMG signals that are recorded
%
% When EMG signals are available, the stucture to get them is:
% LogData.time*.EMGdata
%
% Jessica de Abreu - jxd484@case.edu


% Use this as the folder that contains data for all days
% Change according to where your files are
cd /Volumes/'TOSHIBA EXT'/jessica_neural_modeling/S109_data;
folder_path_dir = dir;
directoryNames = {folder_path_dir([folder_path_dir.isdir]).name};
directoryNames = directoryNames(~ismember(directoryNames,{'.','..'}));

% iterating over days
for i=1:length(directoryNames)
    path_day = fullfile(directoryNames(i), '*.mat');
    log_files = dir(char(path_day));
    log_file_names = {log_files.name};
    % iterating within single day
    for j=1:length(log_file_names)
        path_log = fullfile(directoryNames(i), log_file_names(j));
        load(char(path_log))
        block_names = fieldnames(LogData);
        % iterating within single block
        for k=1:length(block_names)
            sub_block = LogData.(char(block_names(k)));
            if isfield(sub_block, 'EMGdata')
                file_name_split = strsplit(char(log_file_names(j)), '.');
                file_name = file_name_split(1);
                EMG_block.(strcat('date_', char(directoryNames(i)))). ...
                    (char(file_name)).(char(block_names(k))).EMG = ...
                LogData.(char(block_names(k))).EMGdata;
                EMG_block.(strcat('date_', char(directoryNames(i)))). ...
                    (char(file_name)).(char(block_names(k))).StimParams = ...
                LogData.(char(block_names(k))).StimParams;
            end
        end
    end
end