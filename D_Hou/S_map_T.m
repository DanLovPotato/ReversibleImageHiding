function projection =  S_map_T(SDs_1, SDs_2, K)
%function is to give index 

%sort both sets of standard deviations in ascending order

[sorted_SDs_1, tile_idx_1] = sort(SDs_1); 
[sorted_SDs_2, tile_idx_2] = sort(SDs_2); 

%use k-means to classfy tiles into K classes 
%....
%but unsure if it's really helpful????

I = sort(tile_idx_1);
projection = tile_idx_2(I);








