% Script to plot stimulation vs EMG data for a single recording
%
% Jessica de Abreu - jxd484@case.edu

date = 'date_20170628';
block = 'Log_20170628_15754';
sub_block = 'time152148';

freq = EMG_block.(date).(block).(sub_block).StimParams. ...
    Frequency.Params;
pulse_amp = EMG_block.(date).(block).(sub_block).StimParams. ...
    Frequency.Params;
pulse_width = EMG_block.(date).(block).(sub_block).StimParams. ...
    PulseWidth.Params;