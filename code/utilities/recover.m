%% recover process
function s = recover(c, rot, tag, th)
    block = 4;
    [sm, sn] = size(c);
    s = zeros(sm, sn);

    sm = sm / block;
    sn = sn / block;
    vector_L = sm * sn;

    menc = zeros(1, vector_L);
    cb = menc;
    place = cb;
    temp = zeros(block, block);
    k = 0;

    % Analyze blocks to compute cb and menc values
    for i = 1:sm
        for j = 1:sn
            k = k + 1;
            tc = c(block * (i - 1) + 1 : block * i, block * (j - 1) + 1 : block * j);
            [cb(k), menc(k)] = bis(tc);
        end
    end

    % Classify blocks
    [class, cls_L] = classfy_s(cb);
    order = zeros(1, 32);

    % Reconstruct the image
    for i = 1:vector_L
        tg = tag(i) + 1;
        order(tg) = order(tg) + 1;

        ksr = floor((i - 1) / sn);
        ksc = mod(i - 1, sn);

        keyc = class(tg, order(tg));
        kcr = floor((keyc - 1) / sn);
        kcc = mod(keyc - 1, sn);

        tc = c(block * kcr + 1 : block * (kcr + 1), block * kcc + 1 : block * (kcc + 1));

        % Apply threshold and rotation
        if mod(th(i), 2) == 0
            temp = tc - 4 * th(i);
        else
            temp = tc + 4 * th(i);
        end

        if rot(i) == 1
            temp = rot90(temp, -1);
        elseif rot(i) == 2
            temp = rot90(temp, -2);
        elseif rot(i) == 3
            temp = rot90(temp, -3);
        end

        s(block * ksr + 1 : block * (ksr + 1), block * ksc + 1 : block * (ksc + 1)) = temp;
    end
end
