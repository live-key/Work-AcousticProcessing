% Close figures
close all;

addpath data\cali\
speaker_char = load("deg0.mat").y;

% Setup vars
rooms = ["a", "b"];
positions = ["a", "b"];

% Loops through each room and position
addpath data\feat2\
for room = rooms
    labels = [];
    figure;
    for pos = positions
        
        % Grab relevant file and thus imp. resp.
        filename = sprintf("imp_resp_%s_%s.mat", room, pos);
        imp_resp = load(filename).y(4.75e4:9.55e4) - speaker_char(4.75e4:9.55e4); % Correct way of accounting for?
        freq_resp = abs(fft(imp_resp));
        freq_resp = freq_resp(1:floor(length(freq_resp)/2));
        
        % Get max for normalising
        max_gain = max(freq_resp);
        freq_resp = 20*log10(freq_resp/max_gain);
        
        % Plot freq. resp. 
        freq_range = 100:2e4;
        semilogx(freq_range, freq_resp(freq_range)); axis square

        hold on
        
        xlim([100 1e4])
        title(sprintf("Frequency Response: Room %s", upper(room)));
        ylabel("Level (dB)");
        xlabel("Frequency (Hz)");

        labels = [labels sprintf("Position %s", upper(pos))];
    
    end
    legend(labels);
    hold off;
end