% Close figures
close all;

% Calibration factore from cali. file tests in anechoic chamber
CAL = -2.3;

% Octave band cent. freq. and readings
cent_freq = [16, 31.5, 63, 125, 250, 500, 1000, 2000, 4000, 8000];
dB40 = [85, 74, 62, 54, 49, 45, 42, 38 ,35, 32];
room_a = [50.1, 39.7, 36.6, 32.9, 31.1, 30.9, 30.4, 31.5, 29.3, 29.4] + CAL; 
room_b = [57.3, 45.4, 42.4, 38.4, 36.5, 37.9, 36.6, 37.6, 35.4, 34.9] + CAL;
reverb = [41  , 53.9, 76.7, 61  , 54.7, 47.7, 41  , 39.5, 39.5, 48.4] + CAL;

% SIL calc. 
SIL_a = mean(room_a(6:9));
SIL_b = mean(room_b(6:9));
SIL_r = mean(reverb(6:9));

% Plot NCB curves
figure;
semilogx(cent_freq, dB40, "LineWidth", 2); axis square;
hold on;
semilogx(cent_freq, room_a);
semilogx(cent_freq, room_b);
semilogx(cent_freq, reverb);
yline(SIL_a+3, 'label', "Rumble A", 'LineStyle', '--');
yline(SIL_b+3, 'label', "Rumble B", 'LineStyle', '--');
yline(SIL_r+3, 'label', "Rumble Rev", 'LineStyle', '--');

xlim([10, 14e3]);
ylim([0, 100]);

xticks(cent_freq);

title("Room Octave Band NCB Check");
ylabel("SPL");
xlabel("Frequency (Hz)");

legend(["40 dB NCB Curve", "Room A", "Room B", "Reverb Chamber"]);