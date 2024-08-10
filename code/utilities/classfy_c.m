%% Classifies elements into KM classes based on sorted indices
function [class] = classfy_c(sb, cls_L, KM)


    sr = zeros(size(sb));
    [sb, sr] = sort(sb);
    vector_L = length(sr);  
    
    % half of vector_L plus 100 (to accommodate larger classes)
    class = zeros(KM, vector_L/2 + 100);

    % track the current position in sr
    all = 0;

    % Loop over each class to assign sorted elements
    for i = 1:KM
        temp = sr(all + 1:all + cls_L(i));
        temp = sort(temp);        
        % Assign the sorted elements to the current class
        class(i, 1:cls_L(i)) = temp;
        % Update the all variable to move to the next position in sr
        all = all + cls_L(i);
    end
end
