%% Check if h is within the thresholds Tn and Tp
function y = modifiable(l, h, Tn, Tp)
    if h <= Tp && h >= Tn
        y = 0;
        % Calculate the first possible modification
        if h >= 0
            h = 2 * h + 1;
        else
            h = 2 * h;
        end

        % Check if the modification is within the valid range [0, 255]
        if l + h >= 0 && l + h <= 255
            y = y + 1;
        end

        % Check further conditions if the first modification was successful
        if y > 0
            if h <= Tp && h >= Tn
                if h >= 0
                    h = 2 * h + 1;
                else
                    h = 2 * h;
                end
                if l + h >= 0 && l + h <= 255
                    y = y + 1;
                end
            elseif h > Tp
                if l + h + Tp + 1 <= 255
                    y = y + 1;
                end
            elseif h < Tn
                if l + h + Tn >= 0
                    y = y + 1;
                end
            end
        end
    else
        y = 0;
        % Handling when h is greater than Tp or less than Tn
        if h > Tp
            if l + h + Tp + 1 <= 255
                y = -1;
                if l + h + 2 * (Tp + 1) <= 255
                    y = -2;
                end
            end
        elseif h < Tn
            if l + h + Tn >= 0
                y = -1;
                if l + h + 2 * Tn >= 0
                    y = -2;
                end
            end
        end
    end
end
