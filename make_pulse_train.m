function pulse_train = make_pulse_train(freq, amp, width, time)
%% Function makes pulse trains according to inputs
%
% Inputs
% freq: Frequency in Hertz
% amp: pulse amplitude in mA
% width: pulse width in micro seconds
% time: array with time points for pulse train, in seconds.
%
% Outputs:
% pulse_train: pulse train according to inputs
% 
% Jessica de Abreu - jxd484@case.edu
%
width_sec = width / 10^6;
pulse_interval = 1/freq;
% There is a 1 sec delay in the beginning
number_time_points_delay = length(time(time<=1));
number_time_points_width = length(time(time<=width_sec));
number_time_points_shift = length(time(time<=pulse_interval));
single_pulse = zeros(1, number_time_points_shift);

single_pulse(1:number_time_points_width) = -amp;
single_pulse(number_time_points_width:3*number_time_points_width)=0.5*amp;

pulse_train = zeros(1, length(time));
remaining_time_points = mod(length(time)-number_time_points_delay, number_time_points_shift);
number_trains = fix((length(time)-number_time_points_delay)/number_time_points_shift);
stim_result = repmat(single_pulse, [1, number_trains]);
pulse_train(number_time_points_delay+1:length(stim_result)+number_time_points_delay) = stim_result;

if remaining_time_points > 0
   pulse_train(end-remaining_time_points:end) = single_pulse(1:remaining_time_points+1);  
end

end