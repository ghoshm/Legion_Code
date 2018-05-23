% Calculate Grammar Sequence Frequencies for all fish
    % One per thread with 10x shuffles
    % nanmean(calc_time) = 16 mins 
    % nanmean(q_time) = 32 mins 
    
c = parcluster ('LegionGraceProfile'); % Start a terminal session 
num_workers = 1; % specify number of workers 
load('threads.mat'); % load data (threads or threads_hours here) 
load('uniqueSeqs.mat'); % load data
t_one = 1; % lowest time window 
t_two = 8; % highest time window + 1 (8 for threads, 49 for threads_hours)

tic 
for f = 1:size(threads,1) % for each fish 
   
    myJob = createCommunicatingJob(c, 'Type', 'Pool'); % Create a cluster profile 
    myJob.AttachedFiles = {'Grammar_Freq.m'}; % required scripts 
    myJob.NumWorkersRange = [num_workers, num_workers]; % set number of workers 
    task = createTask(myJob, @Grammar_Freq, 2, {threads(f,:,:),uniqueSeqs,t_one,t_two}); % Compress, return 2 outputs, input data 
    submit (myJob); % submit job 
        
end 
toc 

clear 