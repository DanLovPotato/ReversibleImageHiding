function [bpp, psnr, embedded] = embedding(I, BPP)
    % Perform the first round of embedding
    watermarked = embeddingonce(I, BPP/2, 0);
    
    % Perform the second round of embedding
    watermarked = embeddingonce(watermarked, BPP/2, 1);
    
    % Output the final embedded image
    embedded = watermarked;
    
    % Calculate PSNR between the original and watermarked image
    psnr = PSNR(watermarked(:), I(:));
    
    % Set the bits per pixel value
    bpp = BPP;
end
