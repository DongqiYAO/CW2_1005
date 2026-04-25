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
%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

% Parameter setting
duration = 600;
time_array = zeros(1, duration);
temp_array = zeros(1, duration);

% Collect data for 600 seconds (10 minutes)
for i = 1:duration
    voltage = readVoltage(a, 'A0');
    temp_array(i) = (voltage - 0.5) / 0.01; 
    time_array(i) = i;
    pause(1);
end

% Plot temperature vs time
plot(time_array, temp_array);
xlabel('Time (s)');
ylabel('Temperature (deg C)');
title('Capsule Temperature Monitoring');

% Calculate statistics
Tmax = max(temp_array);
Tmin = min(temp_array);
Tavg = mean(temp_array);

% Screen output
disp('Data logging initiated - 21/04/2026 Location - Nottingham');

for m = 0:10
    idx = m * 60 + 1;
    if idx > duration
        idx = duration;
    end
    
    line1 = sprintf('Minute\t\t%d', m);
    disp(line1);
    
    line2 = sprintf('Temperature\t%.2f C', temp_array(idx));
    disp(line2);
end

str_max = sprintf('Max temp\t%.2f C', Tmax);
str_min = sprintf('Min temp\t%.2f C', Tmin);
str_avg = sprintf('Average temp\t%.2f C', Tavg);

disp(str_max);
disp(str_min);
disp(str_avg);

disp('Data logging terminated');

% Write to txt file
fid = fopen('capsule_temperature.txt', 'w');

fprintf(fid, 'Data logging initiated - 21/04/2026 Location - Nottingham\n');

for m = 0:10
    idx = m * 60 + 1;
    if idx > duration
        idx = duration;
    end
    fprintf(fid, 'Minute\t\t%d\n', m);
    fprintf(fid, 'Temperature\t%.2f C\n', temp_array(idx));
end

fprintf(fid, 'Max temp\t%.2f C\n', Tmax);
fprintf(fid, 'Min temp\t%.2f C\n', Tmin);
fprintf(fid, 'Average temp\t%.2f C\n', Tavg);
fprintf(fid, 'Data logging terminated\n');

fclose(fid);
%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Call the temperature monitoring function
temp_monitor(a);


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here