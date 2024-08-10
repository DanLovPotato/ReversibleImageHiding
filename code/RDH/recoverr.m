function s = recover(c, rot, tag, th)
    block = 4;
    [sm, sn] = size(c);
    s = zeros(sm, sn);

    sm = sm / block;
    sn = sn / block;
    vector_L = sm * sn;
    menc = zeros(1, vector_L);
    cb = menc;

    % Analyze blocks to compute cb values
    k = 0;
    for i = 1:sm
        for j = 1:sn
            k = k + 1;   
            tc = c(block*(i-1) + 1:block*i, block*(j-1) + 1:block*j);
            [cb(k), menc(k)] = bis(tc);
        end
    end

    % Classify blocks
    cls_L = zeros(1, 32);
    class = zeros(32, vector_L / (2 * 4) + 100);
    [class, cls_L] = classfy_s(cb);
    order = zeros(1, 32);

    % Reconstruct the image block by block
    for i = 1:vector_L
        keys = i;
        ksr = floor((keys - 1) / sn);
        ksc = mod(keys - 1, sn);
        keyc = i;
        kcr = floor((keyc - 1) / sn);
        kcc = mod(keyc - 1, sn);

        % Extract the block
        tc = c(block * kcr + 1:block * (kcr + 1), block * kcc + 1:block * (kcc + 1));
   
        % Adjust the block based on the threshold
        if mod(th(i), 2) == 0
            temp = tc - 4 * th(i);
        else
            temp = tc + 4 * th(i);
        end
        
        % Apply rotation
        if rot(i) == 1
            temp = rot90(temp, -1);
        elseif rot(i) == 2
            temp = rot90(temp, -2);
        elseif rot(i) == 3
            temp = rot90(temp, -3);
        end
        
        % Place the adjusted block back into the reconstructed image
        s(block * ksr + 1:block * (ksr + 1), block * ksc + 1:block * (ksc + 1)) = temp;
    end
end
