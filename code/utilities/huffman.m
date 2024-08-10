%% Huffman
function messBits = huffman(resSeq)
    % Determine the range and number of symbols in the input sequence
    symbols = min(resSeq):max(resSeq);
    symbolsNum = length(symbols);

    % Calculate the probability of each symbol
    probs = zeros(1, symbolsNum);
    for ii = 1:symbolsNum
        probs(ii) = sum(resSeq == symbols(ii));
    end
    probs = probs / length(resSeq);
    
    % Generate the Huffman dictionary and encode the sequence
    dict = huffmandict(symbols, probs);
    resBits = huffmanenco(resSeq, dict);

    % Determine the maximum length of the Huffman codes
    maxLen = 0;
    for ii = 1:symbolsNum
        codeLen = length(cell2mat(dict(ii, 2)));
        if codeLen > maxLen
            maxLen = codeLen;
        end
    end
    maxLenBit = floor(log2(maxLen)) + 1;

    % Initialize the bit sequence for the dictionary
    dictBits = zeros(1, (maxLen + maxLenBit) * symbolsNum);
    bitsNum = 0;
    
    for ii = 1:symbolsNum
        cellLen = length(cell2mat(dict(ii, 2)));
        dict(ii, 1) = {ii - 1};
        dictBits(bitsNum + 1 : bitsNum + maxLenBit) = de2bi(cellLen, maxLenBit);
        bitsNum = bitsNum + maxLenBit;
        
        dictBits(bitsNum + 1 : bitsNum + cellLen) = cell2mat(dict(ii, 2));
        bitsNum = bitsNum + cellLen;
    end
    dictBits = dictBits(1 : bitsNum);

    % Combine the dictionary and encoded sequence into the final bit sequence
    messBits = [de2bi(symbolsNum - 1, 8)'; de2bi(maxLenBit, 4)'; dictBits'; resBits];
end
