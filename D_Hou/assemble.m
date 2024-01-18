function channel = assemble(blocks,row_numb,col_numb)

[~,b,~] = size(blocks);

km = row_numb; %number of blocks horizontally
kn = col_numb; %number of blocks vertically

channel = zeros(km*b,kn*b);

idx = 1;
for i = 1:km  %row number of the block
    for j = 1:kn %column number of the block
       channel((i-1)*b+1:i*b,(j-1)*b+1:j*b) = blocks(:,:,idx);
       idx = idx+1;
    end
end