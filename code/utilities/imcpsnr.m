%% IMCPSNR Calculate the peak signal-to-noise ratio between two images.
function cpsnr = imcpsnr(X, Y, peak, b)
    if nargin < 3
        peak = 255;
    end
    if nargin < 4
        b = 0;
    end

    % Crop the borders if b > 0
    if b > 0
        X = X(b+1:end-b, b+1:end-b, :);
        Y = Y(b+1:end-b, b+1:end-b, :);
    end

    % MSE
    dif = (X - Y).^2;
    mse = sum(dif(:)) / numel(dif) + 1e-32;

    % CPSNR
    cpsnr = 10 * log10(peak^2 / mse);
end
