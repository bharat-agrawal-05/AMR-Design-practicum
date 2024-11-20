function classify_signal()
    fs = 1000; 
    fc = 100; 
    dataLength = fs; % Length of data (1 second of data)
    numTests = 1000; % Number of testcases

    modTypes = {'ASK', 'FSK', 'PSK', 'AM', 'FM'};
    
    correctCount = 0;
    totalCount = 0;
    actualModTypes = {};
    predictedModTypes = {};

    for i = 1:length(modTypes)
        modType = modTypes{i};

        for j = 1:numTests
            data = randi([0 1], 1, dataLength);
            signal = generateModulatedSignal(data, fs, fc, modType);
            [sigma_ap, sigma_af, sigma_dp] = extract_features(signal, fs);
            detectedModType = classify_based_on_features(sigma_ap, sigma_af, sigma_dp);
            
            isCorrect = strcmp(detectedModType, modType);
            if isCorrect
                correctCount = correctCount + 1;
            end
            totalCount = totalCount + 1;
            
            actualModTypes{end+1} = modType;
            predictedModTypes{end+1} = detectedModType;
        end
    end
    
    accuracy = (correctCount / totalCount) * 100;
    fprintf('Total Accuracy: %.2f%%\n', accuracy);
    
    figure;
    confusionchart(actualModTypes, predictedModTypes, 'RowSummary', 'row-normalized', 'ColumnSummary', 'column-normalized');
    title('Confusion Matrix for Modulation Classification');
end

function modType = classify_based_on_features(sigma_ap, sigma_af, sigma_dp)
    % Revised and expanded thresholds for all modulation types
    if sigma_ap > 0.35 && sigma_ap < 0.45 && sigma_af < 60 && sigma_dp < 200
        modType = 'ASK';
    elseif sigma_ap >= 0.3 && sigma_ap < 0.35 && sigma_af >= 150 && sigma_af < 180 && sigma_dp < 300
        modType = 'FSK';
    elseif sigma_ap >= 0.3 && sigma_ap < 0.36 && sigma_af >= 190 && sigma_dp >= 320
        modType = 'PSK';
    elseif sigma_ap < 0.2 && sigma_af < 5 && sigma_dp < 190
        modType = 'AM';
    elseif sigma_ap < 0.1 && sigma_af > 10 && sigma_af < 20 && sigma_dp < 240
        modType = 'FM';
    else
        modType = 'Unknown'; 
    end
end

function signal = generateModulatedSignal(data, fs, fc, modType)

    dataLength = length(data);
    t = (0:dataLength-1) / fs;
    
    switch modType
        case 'ASK'
            signal = (1 + data) .* cos(2 * pi * fc * t);
        case 'FSK'
            f1 = fc;  
            f2 = fc + 50;  
            signal = cos(2 * pi * (f1 + (f2-f1) * data) .* t);
        case 'PSK'
            signal = cos(2 * pi * fc * t + pi * data);
        case 'AM'
            dataMod = movmean(data, 20); % Low-pass filter for amplitude modulation characteristic
            signal = (1 + dataMod) .* cos(2 * pi * fc * t);
        case 'FM'
            kf = 50; % Frequency sensitivity
            signal = cos(2 * pi * fc * t + 2*pi*kf*cumsum(data)/fs);
        otherwise
            error('Unknown modulation type');
    end
end

function [sigma_ap, sigma_af, sigma_dp] = extract_features(x, fs)
    % Amplitude statistics
    x_envelope = abs(hilbert(x));  
    sigma_ap = std(x_envelope);    
    
    % Phase statistics
    phase = unwrap(angle(hilbert(x)));  
    sigma_dp = std(phase);   
    
    % Frequency statistics
    freqDiff = fs * diff(phase) / (2*pi); 
    sigma_af = std(freqDiff);  
end