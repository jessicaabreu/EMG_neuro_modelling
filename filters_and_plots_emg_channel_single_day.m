function filters_and_plots_emg_channel_single_day(summary_single_day)
%% Function plots EMGs for all muscles in a single day. 
% Each figure is one electrode.
% Each subplot is a muscle, each line is a pulse amplitude.

muscle_names{1} = 'Pronator';
muscle_names{2} = 'FCR';
muscle_names{3} = 'FDS';
muscle_names{4} = 'FCU';
muscle_names{5} = 'Suppinator';
muscle_names{6} = 'ECRB';
muscle_names{7} = 'EDC';
muscle_names{8} = 'ECU';

% 2/pronator, 3/FCR, 4/FDS, 5/FCU, 6/supinator,
% 7/ECRB, 8/ECD, 9/ECU.

nerves_electrode = fieldnames(summary_single_day);

for i=1:length(nerves_electrode)
    figure('NumberTitle', 'off', 'Name', nerves_electrode{i});
    stim_params = fieldnames(summary_single_day.(char(nerves_electrode(i))));
    for j=1:length(stim_params)
        stim = strsplit(char(stim_params(j)), '_');
        amp = summary_single_day.(char(nerves_electrode(i))).(char(stim_params(j)))...
            .Stim.PulseAmplitude.Params(1);
        freq = summary_single_day.(char(nerves_electrode(i))).(char(stim_params(j)))...
            .Stim.Frequency.Params(1);
        width = summary_single_day.(char(nerves_electrode(i))).(char(stim_params(j)))...
            .Stim.PulseWidth.Params(1);
        EMG = summary_single_day.(char(nerves_electrode(i))).(char(stim_params(j)))...
            .EMG;
        filtered_emg = process_emg(EMG);
        % Plot each muscle in a subplot
        time = filtered_emg(:, 1);
        for muscle=1:size(filtered_emg, 2)-1
            subplot(2, 4, muscle)
            plot(time, filtered_emg(:, muscle+1), 'DisplayName', num2str(amp))
            xlabel('Time (s)')
            hold on
            title(muscle_names{muscle});
            legend();
            stim= make_pulse_train(freq, amp, width, time);
            plot(time, (stim)*10 -max((stim)*10), 'HandleVisibility','off')
        end
    end
end

end