% Close figures
close all;

addpath data\feat4\

% Setup vars
C50 = [];
labels = [];
distances = [0.5, 1, 2, 3];
rooms = ["a", "b"];

% Loop through each room and position
for room = rooms
    for dist = 1:length(distances)
        
        % Grab relevant file
        filename = sprintf("imp_resp_%s_%s.mat", num2str(distances(dist)), room);
        imp_resp = load(filename).y;
        
        % Calculate and index C50
        C50(dist) = 10*log10(sum(imp_resp(1:500).^2)/sum(imp_resp(500:end).^2));
    end
    % Plot C50 for each room and position
    plot(distances, C50); hold on
    labels = [labels sprintf("Room %s", upper(room))];
end

legend(labels, 'Location', 'southeast'); axis square
title("50ms Clarity Curves") 
xlabel("Distance (m)");
ylabel("C_{50} (dB)");
xlim([0.3, 3.2]);
xticks(distances);
