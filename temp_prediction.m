function temp_prediction(a)

    % Data buffers
    timeHistory = [];
    tempHistory = [];
    startTime = tic;
    
    % Main loop
    while true
        % Read current time and temperature
        t = toc(startTime);
        voltage = readVoltage(a, 'A0');
        temp = (voltage - 0.5)/0.01;
        
        % Store data
        timeHistory = [timeHistory, t];
        tempHistory = [tempHistory, temp];
        
        % Keep only recent 5 points to reduce noise
        if length(timeHistory) > 5
            timeHistory = timeHistory(end-4:end);
            tempHistory = tempHistory(end-4:end);
        end
        
        % Calculate rate of change (°C per second)
        if length(timeHistory) >= 2
            dt = diff(timeHistory);
            dT = diff(tempHistory);
            ratePerSec = mean(dT ./ dt);
        else
            ratePerSec = 0;
        end
        
        % Convert to °C per minute
        ratePerMin = ratePerSec * 60;
        
        % Predict temperature in 5 minutes (300s)
        predictedTemp = temp + ratePerSec * 300;
        
        % Print information
        fprintf('Time: %.1fs | Current T: %.2f°C | Rate: %.2f°C/min | Predicted T (5min): %.2f°C\n',...
            t, temp, ratePerMin, predictedTemp);
        
        % LED control
        if temp >= 18 && temp <= 24
            % Comfort zone: green ON
            writeDigitalPin(a, 'D3', 1);
            writeDigitalPin(a, 'D5', 0);
            writeDigitalPin(a, 'D7', 0);
        elseif ratePerMin > 4
            % Rapid rise: red ON
            writeDigitalPin(a, 'D3', 0);
            writeDigitalPin(a, 'D5', 0);
            writeDigitalPin(a, 'D7', 1);
        elseif ratePerMin < -4
            % Rapid fall: yellow ON
            writeDigitalPin(a, 'D3', 0);
            writeDigitalPin(a, 'D5', 1);
            writeDigitalPin(a, 'D7', 0);
        else
            % Default: all off
            writeDigitalPin(a, 'D3', 0);
            writeDigitalPin(a, 'D5', 0);
            writeDigitalPin(a, 'D7', 0);
        end
        
        pause(0.5);
    end
end