% Grammar_Freq
function [gCount,gCount_norm] = Grammar_Freq(threads,uniqueSeqs,t_one,t_two)

    % Allocate
    for tc = 1:size(threads,3) % for real & shuffled data 
     gCount{1,tc} =  zeros(size(uniqueSeqs{1,1},1),(t_two-1),'single'); % uniqueSeqs x time windows
    end 
    gCount_norm{1,1} = zeros(size(uniqueSeqs{1,1},1),(t_two-1),'single'); % uniqueSeqs x time windows

    % Loop
    for s = 1:size(uniqueSeqs{1,1},1) % For each sequence
        temp = zeros(size(threads,3),(t_two-1),'single'); % real & shuffles x time windows 
        
        for tc = 1:size(threads,3)  % for real & shuffled data
            % Find each sequence and count it's time windows
            % Note that strfind(str,pattern) outputs the starting index of each
            % occurrence of pattern in str. This is then used to index the
            % time windows of these occurances, and then fed to histcounts
            % which counts the occurances in each time window
            gCount{1,tc}(s,:) = histcounts(threads{1,3,1}...
                (strfind(threads{1,1,tc}',uniqueSeqs{1,1}{s,1})),...
                t_one:t_two);
            temp(tc,:) = gCount{1,tc}(s,:); 
        end
        
        % Z-Score 
        gCount_norm{1,1}(s,:) =  (temp(1,:) - nanmean(temp(2:end,:)))./nanstd(temp(2:end,:)); 
        
    end
    
        % Replace NaN Values with zeros 
        gCount_norm{1,1}(isnan(gCount_norm{1,1})) = 0; 
        
end