%% DeHuffman
function resSeq=dehuffman(messBits)

elemBit=8;
bitsRead=0;
symbolsNum = bi2de(messBits(bitsRead+1:bitsRead+elemBit)')+1;
bitsRead=bitsRead+elemBit;
elemBit=4;
maxLenBit = bi2de(messBits(bitsRead+1:bitsRead+elemBit)');
bitsRead=bitsRead+elemBit;
dict = cell(symbolsNum,2);

for ii=1:symbolsNum
    bitsLen = bi2de(messBits(bitsRead+1:bitsRead+maxLenBit)');
    bitsRead=bitsRead+maxLenBit;
    
    dict(ii,1)={ii-1};
    dict(ii,2)={messBits(bitsRead+1:bitsRead+bitsLen)'};
    bitsRead=bitsRead+bitsLen;
end

resSeq = huffmandeco(messBits(bitsRead+1:end),dict)';