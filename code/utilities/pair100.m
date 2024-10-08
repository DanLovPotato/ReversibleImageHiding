clear;
clc;
cd='D:\DANTONGXIANG\matlab_code_RIT_kmeans\imagedatabase\';

a = dir(cd);
b = a(3:end); % Remove the first two entries
n = length(b); % Get the number of subdirectories/files to process

% Preallocate arrays for storing results
bpp = zeros(1, n); % Bits per pixel
transform_rmse = zeros(1, n); % RMSE
stego_rmse = zeros(1, n); 

for i = 1:n
    % Construct paths to the secret and target images
    secret_image_path = strcat(cd, b(i).name, '\secret.tiff');
    target_image_path = strcat(cd, b(i).name, '\target.tiff');
    
    % Read the secret and target images
    ss = imread(secret_image_path);
    cc = imread(target_image_path);
    
    % This function should calculate transform RMSE, stego RMSE, and BPP
    [transform_rmse(i), stego_rmse(i), class_bits, bpp(i)] = transform(ss, cc, 10, 10);
end

% The following section is commented out for parallel processing
% Uncomment to use parallel processing if needed
% parpool;
% parfor i = 1:n
%     secret_image_path = strcat(cd, b(i).name, '\secret.tiff');
%     target_image_path = strcat(cd, b(i).name, '\target.tiff');
%     
%     ss = imread(secret_image_path);
%     cc = imread(target_image_path);
%     
%     [transform_rmse(i), stego_rmse(i), class_bits, bpp(i)] = transform(ss, cc, 10, 10);
% end


