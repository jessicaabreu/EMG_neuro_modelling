function summary_channel =summarize_channel_pulseamp_emg()
%% Summarizes EMGs per channel and pulse amplitude
%
% Creates a structure according to:
% channel.pulse_amplitude.emg_signal
% Other parameters were not changed (freq=100 hz, pulse width=250 micro sec)
%
cd /Volumes/Jessica/20190626;

fileList = dir('*.mat');

for file_number=1:length(fileList)
    file = fileList(file_number).name;
    fullFileName = fullfile(fileList(file_number).folder, file);
    load(fullFileName);
    blocks = fieldnames(LogData);
    for block_number=1:length(blocks)
        block = blocks(block_number);
        block = block{1};
        channel = strcat(LogData.(block).StimParams.Nerve,  '_'...
            ,num2str(LogData.(block).StimParams.CathodeChannel(1)));      
        pulse_amp = LogData.(block).StimParams.PulseAmplitude.Params(1);
        str_pulse_amp = num2str(pulse_amp);
        str_pulse_amp = strcat('amp_', strrep(str_pulse_amp,'.','_'));
        EMG_data = LogData.(block).EMGdata;
        summary_channel.(channel).(str_pulse_amp).(block).EMG_data = EMG_data;
        summary_channel.(channel).(str_pulse_amp).(block).pulse_amp = pulse_amp;
    end
end