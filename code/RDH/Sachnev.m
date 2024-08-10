% function res = Sachnev(I, mse)
% I = imread('recover.png');   % Load an image
% I = I(:,:,2);                % Use only the green channel for processing

function res = Sachnev(I, mse)
    I = double(I);  % Convert the image to double precision

    % Initialize storage for BPP (bits per pixel) and PSNR (Peak Signal-to-Noise Ratio)
    bpp = zeros(100, 1000);
    psnr = zeros(100, 1000);
    pforbpp = 0;  % Counter for valid BPP values

    for Th = mse
        [b, p, embedded] = embedding(I, Th);  % Perform embedding
        [Th, b, p] 
        if b > 0  % Check if a valid embedding was performed
            pforbpp = pforbpp + 1;
            bpp(pforbpp) = b;
            psnr(pforbpp) = p;
        end
    end

    res = embedded;  % Return the embedded image

    % Optional code for saving and plotting results
    % imwrite(embedded, 'embeded.png');
    % bpp = bpp(1:pforbpp);
    % psnr = psnr(1:pforbpp);
    % plot(bpp, psnr, '-r.');

    % Save the BPP and PSNR values
    % Sachnev_House = zeros(2, pforbpp);
    % Sachnev_House(1, :) = bpp;
    % Sachnev_House(2, :) = psnr;
    % save Sachnev_House.mat Sachnev_House
end
