% Dongqi YAO 20720155
% ssydy4@nottingham.edu.cn


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]
clear all
clc

a = arduino();

for k = 1:10
    writeDigitalPin(a, 'D2', 1);
    pause(0.5);
    writeDigitalPin(a, 'D2', 0);
    pause(0.5);
end
%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Call the temperature monitoring function
temp_monitor(a);