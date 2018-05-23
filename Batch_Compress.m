% Compress Loads of Fish & Their Shuffles 
    % One per thread with 10x Shuffles 
    % nanmean(q_time) = 1.6mins 
    % nanmean(compression_time) = 1h 15mins
    % (max(compression_time))/60 = 7hours 
    
 c = parcluster ('LegionGraceProfile'); % Start a terminal session 
 num_workers = 1; % specify number of workers 
 load('threads.mat'); % load data 
 sMax = 11; % Hard Coded Starting State 
 nMax = 10; % Hard Coded Max N-Gram to look for 
    
tic 
for f = 1:size(threads,1) % for each fish 
   
    myJob = createCommunicatingJob(c, 'Type', 'Pool'); % Create a cluster profile 
    myJob.AttachedFiles = {'Compress.m'  'compressSequenceNFast.m' 'getGrammarTerminals.m' ...
        'compressiveNFast.m' 'expandGrammar.m' 'n_gramsNumerical.m' 'countUniqueRows.m'}; % required scripts 
    myJob.NumWorkersRange = [num_workers, num_workers]; % set number of workers 
    task = createTask(myJob, @Compress, 4, {threads(f,1,:),sMax,nMax}); % Compress, return 4 outputs, input data 
    submit (myJob); % submit job 
        
end 
toc 

clear 