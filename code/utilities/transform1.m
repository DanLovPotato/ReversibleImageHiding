function [transform_rmse, class_bits, bpp, C1, sc] = transform1(ss, cc, KM, T, block)
    addpath('RDH\');

    % Ensure the matfiles directory exists in the same directory as the code
    if ~exist('matfiles', 'dir')
        mkdir('matfiles');
    end

    % Ensure the results directory exists one level above the code directory
    if ~exist('../results', 'dir')
        mkdir('../results');
    end

    % Convert images to double precision
    ss = double(ss);
    cc = double(cc);
    sc = cc;

    % Transformation for RGB channels 
    for i = 1:3
        [sc(:,:,i), th_vector(i,:), rot_vector(i,:), place_vector(i,:)] = shift(ss(:,:,i), cc(:,:,i), KM, T, block);
    end

    % Handle overflow and underflow issues in the transformed image
    sc_liner = sc(:);
    redu = find((sc_liner >= 255) | (sc_liner <= 0)); % Find overflow/underflow pixels
    L_redu = length(redu);
    flow = zeros(1, L_redu);
    
    for i = 1:L_redu
        if sc_liner(redu(i)) > 255
            flow(i) = sc_liner(redu(i)) - 255;
            sc_liner(redu(i)) = 255;
        elseif sc_liner(redu(i)) < 0
            flow(i) = -sc_liner(redu(i));
            sc_liner(redu(i)) = 0;
        end
    end

    % Reshape the modified image back to its original dimensions
    [m, n] = size(ss(:,:,1));
    sc = reshape(sc_liner, m, n, 3);
    
    % Save transformation information in separate .mat files in the matfiles directory
    save('matfiles/rot_vector.mat', 'rot_vector');
    save('matfiles/place_vector.mat', 'place_vector');
    save('matfiles/th_vector.mat', 'th_vector');
    save('matfiles/flow.mat', 'flow');
    
    % Rotate and encode transformation information
    rot_inf = de2bi(rot_vector(:));
    rot_inf = rot_inf(:)';
    num_blocks = m * n * 3 * 5 / (block * block);
    L2 = length(dec2bin(num_blocks));
    
    % Calculate and encode class information
    re1 = huffman(place_vector(:));
    class_bits = length(re1) * 16 / (m * n * 3);
    L_inf = de2bi(length(re1), L2);

    % Calculate and encode pixel mean difference information
    re2 = huffman(th_vector(:));

    % Encode overflow/underflow information
    re3 = huffman(flow');
    L_flow = length(dec2bin(3 * m * n / 2));
    L_flowinf = de2bi(length(re3), L_flow);

    % Concatenate all encoded information into a single bitstream
    messstream = [rot_inf, L_inf, re1', L_flowinf, re3', re2'];
    save('matfiles/mess.mat', 'messstream');
    
    % Calculate bpp
    bpp = length(messstream) / (m * n * 3);

    %  RMSE 
    transform_rmse = appraise(sc, cc);

    % Convert the image back to uint8 format for saving
    sc = uint8(sc);

    % Save the intermediate transformed image before RDH in the results directory one level up
    imwrite(sc, '../results/transfer1.png'); 

    % Prepare the output transformed image data
    C1 = [sc(:,:,1), sc(:,:,2), sc(:,:,3)];
end
