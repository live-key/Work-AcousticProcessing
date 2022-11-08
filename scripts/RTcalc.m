function RT = RTcalc(type, EDC)

if type == "EDT"
    start = 0;
    fin = -10;
elseif type == "T20"
    start = -5;
    fin = -20;
end

Y = EDC(min(find(EDC<start)):min(find(EDC<fin)))';
X = [ones(length(Y), 1) , (1:length(Y))'];
beta = X \ Y;
X = [ones(length(EDC), 1) , (1:length(EDC))'];
RT = min(find((X * beta)<-60))/1e4;
end