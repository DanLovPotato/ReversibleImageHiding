%% shift transformation
function [b, th_vector, rot_vector, tag] = shift(s, c, KM, T, block)
    [sm, sn] = size(s);
    b = double(zeros(sm, sn));
    
    sm = sm / block;
    sn = sn / block;
    vector_L = sm * sn;
    th_vector = zeros(1, vector_L);
    tag = zeros(1, vector_L);
    sb = tag;
    cb = tag;
    k = 0;

    % Analyze blocks to compute sb and cb values
    for i = 1:sm
        for j = 1:sn
            k = k + 1;
            ts = s(block*(i-1) + 1 : block*i, block*(j-1) + 1 : block*j);
            tc = c(block*(i-1) + 1 : block*i, block*(j-1) + 1 : block*j);
            [sb(k), ~] = bis(ts);
            [cb(k), ~] = bis(tc);
        end
    end
    
    q_sb = round(sb);
    q_cb = round(cb);
    class_s = zeros(KM, vector_L/2 + 100);
    class_c = class_s;

    % Perform K-means clustering on sb
    [class_index, cls_L] = K_means(sb', KM);
    for i = 1:KM
        class_s(i, 1:length(class_index{i})) = class_index{i};
    end

    % Classify cb into clusters
    class_c = classfy_c(cb, cls_L, KM);

    k = 0;
    for i = 1:KM
        for j = 1:cls_L(i)
            k = k + 1;
            keyc = class_c(i, j);
            kcr = floor((keyc-1) / sn);
            kcc = mod(keyc-1, sn);
            keys = class_s(i, j);  
            ksr = floor((keys-1) / sn);
            ksc = mod(keys-1, sn);
            tag(keys) = i-1;

            tc = c(block*kcr + 1 : block*(kcr + 1), block*kcc + 1 : block*(kcc + 1));
            ts = s(block*ksr + 1 : block*(ksr + 1), block*ksc + 1 : block*(ksc + 1));

            % Compute and adjust the shift (th)
            th = round(mean(tc(:)) - mean(ts(:)));
            t = ts + th;

            if max(t(:)) > 255
                if (max(t(:)) - 255) < T
                    th = th - (max(t(:)) - 255);    
                else
                    th = th - T;
                end
            end

            if min(t(:)) < 0
                if (0 - min(t(:))) < T
                    th = th + (0 - min(t(:)));    
                else
                    th = th + T;
                end
            end

            % Quantize the shift value (th)
            if th > 0
                th = 8 * round(th / 8);
            else
                th = 8 * floor(th / 8) + 4;
            end
            
            t = ts + th;
            th_vector(keys) = abs(th / 4);

            % Determine the optimal rotation
            t1 = double(uint8(t));
            b1 = sum((t1(:) - tc(:)).^2);
            b2 = sum((rot90(t1, 1)(:)-tc(:)).^2);
            b3 = sum((rot90(t1, 2)(:)-tc(:)).^2);
            b4 = sum((rot90(t1, 3)(:)-tc(:)).^2);

            [bs, rot] = min([b1, b2, b3, b4]);
            if rot > 1
                t = rot90(t, rot-1);
            end

            rot_vector(keys) = rot - 1;
            b(block*kcr + 1 : block*(kcr + 1), block*kcc + 1 : block*(kcc + 1)) = t;
        end
    end
end
