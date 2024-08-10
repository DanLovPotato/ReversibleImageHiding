%% Calculate the Root Mean Square Error (RMSE) between two images
function mse = appraise(img1, img2)

    img1 = double(img1);
    img2 = double(img2);

    % the number of elements (pixels) in the image
    L = length(img1(:));

    % MSE
    mse = sum(sum(sum((img1 - img2).^2))) / L;

    % Convert MSE to RMSE
    mse = sqrt(mse);

end
