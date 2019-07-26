function [summary_day, summary_channel]=summarize_emg_channel_day(EMG_block)
%% Summarizes EMGs per day and channel
%
% Creates a structure according to: 
%   nerve_channel.stim_params.EMG/Stim or
%   day.nerve_channel.stim_params.EMG/Stim

fields = fieldnames(EMG_block);

for day=1:length(fields)
    blocks = fieldnames(EMG_block.(char(fields(day))));
    for block=1:length(blocks)
        times = fieldnames(EMG_block.(char(fields(day))).(char(blocks(block))));
        for time=1:length(times)
            EMG_data = EMG_block.(char(fields(day))).(char(blocks(block))). ...
                (char(times(time))).EMG;
            stim_param = EMG_block.(char(fields(day))).(char(blocks(block))). ...
                (char(times(time))).StimParams;
            channel = stim_param.CathodeChannel(1);
            nerve = stim_param.Nerve;
            
            summary_channel.(strcat(nerve, num2str(channel))).(strcat('params', ...
                num2str(stim_param.Frequency.Params), '_', ...
                num2str(stim_param.PulseWidth.Params), '_', ...
                strrep(num2str(stim_param.PulseAmplitude.Params(1)), '.', ''))). ...
                (strcat('EMG', '_', char(fields(day)), '_', char(blocks(block)), ...
                '_', char(times(time)))) = EMG_data;
            
            summary_channel.(strcat(nerve, num2str(channel))).(strcat('params', ...
                num2str(stim_param.Frequency.Params), '_', ...
                num2str(stim_param.PulseWidth.Params), '_', ...
                strrep(num2str(stim_param.PulseAmplitude.Params(1)), '.', ''))). ...
                (strcat('Stim', '_', char(fields(day)), '_', char(blocks(block)), ...
                '_', char(times(time)))) = stim_param;
            
            summary_day.(char(fields(day))).(strcat(nerve, num2str(channel))). ...
                (strcat('params', num2str(stim_param.Frequency.Params), '_', ...
                num2str(stim_param.PulseWidth.Params), '_', ...
                strrep(num2str(stim_param.PulseAmplitude.Params(1)), '.', ''))). ...
                EMG = EMG_data;
            
            summary_day.(char(fields(day))).(strcat(nerve, num2str(channel))). ...
                (strcat('params', num2str(stim_param.Frequency.Params), '_', ...
                num2str(stim_param.PulseWidth.Params), '_', ...
                strrep(num2str(stim_param.PulseAmplitude.Params(1)), '.', ''))). ...
                Stim=stim_param;
        end
    end
end