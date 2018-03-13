% Compress Per Hour
function [totSavings] = Compress_Hours(threads,sMax,nMax)
            
            % Allocate 
            totSavings = nan(size(threads,1),max(threads{1,3,1}),size(threads,3)); % fish x hours x (data + control shuffles) 
            
        for tc = 1:size(threads,3) % for real and shuffled data 
            for h = min(threads{1,3,1}):max(threads{1,3,1}) % for each hour 
            % Compress
            try 
            [~,~, totSavings(1,h,tc)] = ...
                compressSequenceNFast(threads{1,1,tc}...
                (threads{1,3,1} == h,1)',sMax,nMax);
            catch 
            end 
            end 
        end
    
end 