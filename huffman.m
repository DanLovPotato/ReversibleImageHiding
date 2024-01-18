function messBits=huffman(resSeq)
symbols = min(resSeq):max(resSeq);

symbolsNum = length(symbols);
probs = zeros(1,symbolsNum);
for ii=1:symbolsNum
    probs(ii) = sum(resSeq==symbols(ii));
end
probs = probs/length(resSeq);
dict = huffmandict(symbols,probs);
resBits = huffmanenco(resSeq,dict);

maxLen=0;
for ii=1:symbolsNum
    if length(cell2mat(dict(ii,2)))>maxLen
        maxLen = length(cell2mat(dict(ii,2)));
    end
end
maxLenBit=floor(log2(maxLen))+1;

dictBits=zeros(1,(maxLen+maxLenBit)*symbolsNum);
bitsNum=0;
for ii=1:length(symbols)
    cellLen = length(cell2mat(dict(ii,2)));
    dict(ii,1)={ii-1};
    dictBits(bitsNum+1:bitsNum+maxLenBit)=de2bi(cellLen,maxLenBit);
    bitsNum = bitsNum+maxLenBit;
    
    dictBits(bitsNum+1:bitsNum+cellLen)=cell2mat(dict(ii,2));
    bitsNum = bitsNum+cellLen;
end
dictBits=dictBits(1:bitsNum);
messBits=[de2bi(symbolsNum-1,8)'; de2bi(maxLenBit,4)'; dictBits'; resBits];