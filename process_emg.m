function processed_emg = process_emg(signal)
%% Function rectifies and bandpasss filters emg signals using 3rd order butterworth and normalizes.
%
% Inputs:
%   signal: double containing an nx10 array of emg signals. Each column is a
%   muscle according to: 2/pronator, 3/FCR, 4/FDS, 5/FCU, 6/supinator,
%   7/ECRB, 8/ECD, 9/ECU.
%
% Outputs:
%   filtered_emg: double containing nx9 processed emg signals. First
%   column is time.
%
% Jessica Abreu - jxd484@case.edu
%
% Valid signals are from 2-9
% Column 1 is time, last column is not valid

fl = 20;
fh = 900;
n1 = 58.5;
n2 = 61.5;

processed_emg = zeros(size(signal, 1), size(signal, 2)-1);
processed_emg(:, 1) = signal(:, 1);
emg_samp_freq = 1 / (signal(2, 1) - signal(1, 1)); % hz


for i=2:size(signal, 2)-1
    signal_to_filter = signal(:, i);
    [b,a]=butter(3,[fl,fh]/(emg_samp_freq/2),'bandpass');
    bandpass_filtered_channel = filter(b, a, signal_to_filter);
    [d,c] = butter(3, [n1, n2]/(emg_samp_freq/2), 'stop'); % notch
    band_notch_filtered_channel = filter(d, c, bandpass_filtered_channel);
    rectified_signal = abs(band_notch_filtered_channel);
    [f,e] = butter(3, 10/(emg_samp_freq/2), 'low'); % smooth
    smoothed = filtfilt(f, e, rectified_signal);
    max_value= max(smoothed);
    norm_smoothed = smoothed / max_value;
    processed_emg(:,i) = norm_smoothed;
end