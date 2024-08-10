%% This function divides data into K clusters and returns the index of each cluster and its center.
function [class_index,class_L]=K_means(SD,K)
    
    class_L = zeros(K, 1);
    class_index_temp = cell(K, 1);
    class_index = cell(K, 1);
    [disto_sort, index] = sort(SD);
    [m, ~] = size(disto_sort);
    
    if m == 1
        disto_sort = disto_sort';
    end

    save('matfiles/disto_sort.mat', 'disto_sort');

    % Perform K-means clustering
    [data_cluster, center] = kmeans(disto_sort, K, 'distance', 'sqEuclidean', ...
                                'emptyaction', 'singleton', 'Start', 'uniform', ...
                                'rep', 1, 'MaxIter', 400);

    for i = 1:K
        temp = [];
        temp = find(data_cluster == i);
        class_index_temp{i} = sort(index(temp));
    end

    [~, center_index] = sort(center);
    for i = 1:K
        class_index{i} = class_index_temp{center_index(i)};
        class_L(i) = length(class_index{i});
    end

    save('matfiles/class_index.mat', 'class_index');
    save('matfiles/class_L.mat', 'class_L');

end
