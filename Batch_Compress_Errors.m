% Compress Fish Who Errored 
    % One per Thread 
    
 c = parcluster ('LegionGraceProfile'); % Start a terminal session 
 num_workers = 1; % specify number of workers 
 load('threads.mat'); % load data 
 load('Results.mat','errors'); % load fish who errored 
 sMax = 11; % Hard Coded Starting State 
 nMax = 10; % Hard Coded Max N-Gram to look for 
    
tic 
for f = errors % for each fish 
   
    myJob = createCommunicatingJob(c, 'Type', 'Pool'); % Create a cluster profile 
    myJob.AttachedFiles = {'Compress.m'  'compressSequenceNFast.m' 'getGrammarTerminals.m' ...
        'compressiveNFast.m' 'expandGrammar.m' 'n_gramsNumerical.m' 'countUniqueRows.m'}; % required scripts 
    myJob.NumWorkersRange = [num_workers, num_workers]; % set number of workers 
    task = createTask(myJob, @Compress, 4, {threads(f,1,:),sMax,nMax}); % Compress, return 4 outputs, input data 
    submit (myJob); % submit job 
        
end 
toc 

clear 