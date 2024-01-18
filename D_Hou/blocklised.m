function blocks = blocklised(channel, block_size)
%the function is to slice the colour channel into 4*4 tiles

b = block_size; 
[m,n] = size(channel); 

km = floor(m/b); %number of blocks horizontally
kn = floor(n/b); %number of blocks vertically

channel = channel(1:km*b,1:kn*b);  %chop off the extra-marginal area

blocks = zeros(b,b,km*kn); %a 3d matrix stroes all tiles

idx = 1;
for i = 1:km  %row number of the block
    for j = 1:kn %column number of the block
       blocks(:,:,idx) = channel((i-1)*b+1:i*b,(j-1)*b+1:j*b);
       idx = idx+1;
    end
end


