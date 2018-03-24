% Compress Fish Who Errored Per Hour 
    % One per Thread 
    
 c = parcluster ('LegionGraceProfile'); % Start a terminal session 
 num_workers = 1; % specify number of workers 
 load('threads_hours.mat'); % load data 
 load('Results.mat','errors'); % load fish who errored 
 sMax = 17; % Hard Coded Starting State 
 nMax = 10; % Hard Coded Max N-Gram to look for 
    
tic 
for f = errors % for each fish 
   
    myJob = createCommunicatingJob(c, 'Type', 'Pool'); % Create a cluster profile 
    myJob.AttachedFiles = {'Compress_Hours.m'  'compressSequenceNFast.m' 'getGrammarTerminals.m' ...
        'compressiveNFast.m' 'expandGrammar.m' 'n_gramsNumerical.m' 'countUniqueRows.m'}; % required scripts 
    myJob.NumWorkersRange = [num_workers, num_workers]; % set number of workers 
    task = createTask(myJob, @Compress_Hours, 1, {threads_hours(f,:,:),sMax,nMax}); % Compress, return 1 output, input data 
    submit (myJob); % submit job 
        
end 
toc 

clear 