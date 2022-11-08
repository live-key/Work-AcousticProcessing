% Close figures
close all;

% Set up vars
third_cf = [250, 315, 400, 500, 630, 800, 1000, ...
    1250, 1600, 2000, 2500, 3150, 4000];
rooms = ["a", "b"];
positions = ["a", "b"];

% Loops through each room and position 
addpath data\feat2\
for room = 1:length(rooms)
    % Set up and reset iterable matrices
    EDT = zeros(length(positions), length(third_cf));
    T20 = zeros(length(positions), length(third_cf));
    for pos = 1:length(positions)
        
        % Grab relevant file and thus imp. resp. 
        filename = sprintf("imp_resp_%s_%s.mat", rooms(room), positions(pos));
        imp_resp = load(filename).y(4.75e4:9.55e4); 
        
        % Open new fig.
        figure;
        
        % Set up relevant vars
        EDC = [];
        labels = [];
        y = [];

        % Loop through third octave band freq. 
        for cf = 1:length(third_cf)
            % Produce third octave-band passband filter bank
            [B,A] = oct3dsgn(third_cf(cf), 4.8e4, 3);
            y = filter(B,A,imp_resp);
            
            % Compute EDC using filtered imp. resp. 
            for kk = 1:length(y)
                EDC(kk) = sum(y(kk:end).^2);
            end
            
            % Normalise
            EDC = 10*log10(EDC/max(EDC));
            
            % Calc. RT
            EDT(pos,cf) = RTcalc("EDT", EDC);
            T20(pos,cf) = RTcalc("T20", EDC);
            
            % Plot EDCs
            plot(EDC); axis square; hold on;

            title(sprintf("EDC - Room %s, Position %s", upper(rooms(room)), upper(positions(pos))));
            ylabel("Level (dB)");
            xlabel("Time (\times10^{-4} s)");

        end
    end
    hold off;

    % Open new fig.
    figure;
    
    % Plot RTs
    semilogx(third_cf, EDT(1,:)); axis square; hold on
    semilogx(third_cf, EDT(2,:))
    semilogx(third_cf, T20(1,:));
    semilogx(third_cf, T20(2,:));
    hold off;
    
    title(sprintf("Reverberation Time - Room %s", upper(rooms(room))));
    ylabel("RT (s)");
    xlabel("Frequency (Hz)");

    xticks(third_cf);

    labels =   ["EDT - position A"
                "EDT - position B"
                "T20 - position A"
                "T20 - position B"];
    legend(labels);
end
