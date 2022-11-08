close all;
clear;

rmdir("data\", "s");
mkdir data
cd data\
mkdir cali
mkdir feat2
mkdir feat4
cd ..\

% Anechoic Data
for ii = 1:4
    cd anechoic\ 
    filename = sprintf("deg%d.wav", (ii-1)*90);
    [y, ~] = audioread(filename);
    cd ..\data\cali
    filename = sprintf("deg%d.mat", (ii-1)*90);
    save(filename, "y");
    cd ..\..
end

% Room A
cd room_a\feat2\ 
[y, ~] = audioread("imp_resp_a.wav");
cd ..\..\data\feat2
save("imp_resp_a_a.mat", "y");
cd ..\..\room_a\feat2\

[y, ~] = audioread("imp_resp_b.wav");
cd ..\..\data\feat2
save("imp_resp_b_a.mat", "y");
cd ..\..

for ii = 1:4
    cd room_a\feat4\ 
    
    if (ii == 1)
        filename = "imp_resp_0.5.wav";
    else
        filename = sprintf("imp_resp_%d.0.wav", (ii-1));
    end

    [y, ~] = audioread(filename);
    cd ..\..\data\feat4

    if (ii == 1)
        filename = "imp_resp_0.5_a.mat";
    else
        filename = sprintf("imp_resp_%.1d_a.mat", (ii-1));
    end

    save(filename, "y");
    cd ..\..
end

% Room B
cd room_b\feat2\ 
[y, ~] = audioread("imp_resp_a.wav");
cd ..\..\data\feat2
save("imp_resp_a_b.mat", "y");
cd ..\..\room_b\feat2\

[y, ~] = audioread("imp_resp_b.wav");
cd ..\..\data\feat2
save("imp_resp_b_b.mat", "y");
cd ..\..

for ii = 1:4
    cd room_b\feat4\ 
    
    if (ii == 1)
        filename = "imp_resp_0.5.wav";
    else
        filename = sprintf("imp_resp_%d.0.wav", (ii-1));
    end

    [y, ~] = audioread(filename);
    cd ..\..\data\feat4

    if (ii == 1)
        filename = "imp_resp_0.5_b.mat";
    else
        filename = sprintf("imp_resp_%.1d_b.mat", (ii-1));
    end

    save(filename, "y");
    cd ..\..
end