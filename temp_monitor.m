function temp_monitor(a)

%TEMP_MONITOR Real-time temperature monitoring system
%This function reads temperature from a sensor, controls three LEDs 
%with synchronized timing, updates a real-time plot periodically, 
%and provides visual alerts. Green LED for comfort zone, 
%yellow and red LEDs blink at fixed rates for low/high temperature.

% Green LED: ON when temperature is between 18°C and 24°C
% Yellow LED: Blinks every 0.5s when temperature < 18°C
% Red LED: Blinks every 0.25s when temperature > 24°C

    % Initialize data storage arrays
    time_list = [];
    temp_list = [];
    count = 0;
    
    % Infinite loop for real-time monitoring
    while true
        % Read voltage from temperature sensor (A0)
        voltage = readVoltage(a, 'A0');
        
        % Convert voltage to temperature
        temp = (voltage - 0.5) / 0.01;
        
        % Update time and temperature arrays
        count = count + 1;
        time_list = [time_list, count];
        temp_list = [temp_list, temp];
        
        % Plot real-time temperature graph
        plot(time_list, temp_list, 'b-', 'LineWidth', 1);
        xlabel('Time (s)');
        ylabel('Temperature (°C)');
        title('Real-time Capsule Temperature Monitoring');
        ylim([0 40]);
        grid on;
        drawnow;  % Update plot immediately
        
        % LED control logic based on temperature
        if temp >= 18 && temp <= 24
            % Normal temperature: Green LED ON
            writeDigitalPin(a, 'D3', 1);
            writeDigitalPin(a, 'D5', 0);
            writeDigitalPin(a, 'D7', 0);
            pause(1);
            
        elseif temp < 18
            % Low temperature: Yellow LED blinks (0.5s interval)
            writeDigitalPin(a, 'D3', 0);
            writeDigitalPin(a, 'D5', 1);
            writeDigitalPin(a, 'D7', 0);
            pause(0.5);
            
            writeDigitalPin(a, 'D5', 0);
            pause(0.5);
            
        else
            % High temperature: Red LED blinks (0.25s interval)
            writeDigitalPin(a, 'D3', 0);
            writeDigitalPin(a, 'D5', 0);
            writeDigitalPin(a, 'D7', 1);
            pause(0.25);
            
            writeDigitalPin(a, 'D7', 0);
            pause(0.25);
        end
    end
end