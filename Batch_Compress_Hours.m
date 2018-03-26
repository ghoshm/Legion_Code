% Compress Loads of Fish & Their Shuffles Per Hour
    % One per thread with 10x Shuffles 
    % nanmean(q_time) = 1.6
    % nanmean(compression_time) = 7.7
    % (max(compression_time))/60 =  0.5
    
 c = parcluster ('LegionGraceProfile'); % Start a terminal session 
 num_workers = 1; % specify number of workers 
 load('threads_hours.mat'); % load data 
 sMax = 17; % Hard Coded Starting State 
 nMax = 10; % Hard Coded Max N-Gram to look for 
    
tic 
for f = 1:size(threads,1) % for each fish 
   
    myJob = createCommunicatingJob(c, 'Type', 'Pool'); % Create a cluster profile 
    myJob.AttachedFiles = {'Compress_Hours.m'  'compressSequenceNFast.m' 'getGrammarTerminals.m' ...
        'compressiveNFast.m' 'expandGrammar.m' 'n_gramsNumerical.m' 'countUniqueRows.m'}; % required scripts 
    myJob.NumWorkersRange = [num_workers, num_workers]; % set number of workers 
    task = createTask(myJob, @Compress_Hours, 1, {threads(f,:,:),sMax,nMax}); % Compress, return 1 output, input data 
    submit (myJob); % submit job 
        
end 
toc 

clear 