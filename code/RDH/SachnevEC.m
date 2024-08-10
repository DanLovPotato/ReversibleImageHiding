clear all;   
clc

% Read the input image and convert it to double precision for processing
I = imread('.\data\Peppers.bmp');   
I = double(I);

% Initialize arrays to store BPP (bits per pixel) and PSNR (peak signal-to-noise ratio) values
bpp = zeros(1, 26);
psnr = zeros(1, 26);
pforbpp = 0;  % Counter for valid BPP values

% Loop through different threshold values (Th) to evaluate embedding performance
for Th = 1:26
    Capacity = 1000 + Th * 1000;  % Define capacity based on the current threshold
    [b, p, embedded] = embedding(I, Capacity / 512^2);  % Perform embedding with calculated capacity
    [Th, b, p]  % Display the threshold, BPP, and PSNR values

    if b > 0  % If embedding was successful, store the results
        pforbpp = pforbpp + 1;
        bpp(pforbpp) = Capacity;
        psnr(pforbpp) = p;
    end
end

% Trim the BPP and PSNR arrays to the valid entries
bpp = bpp(1:pforbpp);
psnr = psnr(1:pforbpp);

plot(bpp, psnr, '-r.');
xlabel('Capacity (bits)');
ylabel('PSNR (dB)');
title('Embedding Performance');

SachnevEC_Peppers = zeros(2, pforbpp);
SachnevEC_Peppers(1, :) = bpp;
SachnevEC_Peppers(2, :) = psnr;

save('SachnevEC_Peppers.mat', 'SachnevEC_Peppers');
