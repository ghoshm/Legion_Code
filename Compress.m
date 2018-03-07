% Compress
function [grammar,compVec,totSavings,gTermCell] = Compress(threads,sMax,nMax)
            
            % Allocate 
            grammar = cell(size(threads,1),size(threads,3)); % fish x (data + control shuffles) 
            compVec = cell(size(threads,1),size(threads,3)); % fish x (data + control shuffles) 
            totSavings = zeros(size(threads,1),size(threads,3)); % fish x (data + control shuffles) 
            gTermCell = cell(size(threads,1),size(threads,3)); % cell for storing n-grams 
            
    for f = 1:size(threads,1) % for each fish 
        for tc = 1:size(threads,3) % for real and shuffled data 
            % Compress
            [grammar{f,tc}, compVec{f,tc}, totSavings(f,tc)] = ...
                compressSequenceNFast(threads{f,1,tc}',sMax,nMax);

            % Get terminal symbols
            gTermCell{f,tc} = getGrammarTerminals(grammar{f,tc});
        end
    end
    
end 