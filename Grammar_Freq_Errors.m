% Grammar_Freq Fish Who Errored 
    % One per Thread 
    
c = parcluster ('LegionGraceProfile'); % Start a terminal session 
num_workers = 1; % specify number of workers 
load('threads_hours.mat'); % load data 
load('uniqueSeqs.mat'); % load data
load('Results.mat','errors'); % load fish who errored 
t_one = 1; 
t_two = 49; 
    
tic 
for f = errors % for each fish 
   
    myJob = createCommunicatingJob(c, 'Type', 'Pool'); % Create a cluster profile 
    myJob.AttachedFiles = {'Grammar_Freq.m'}; % required scripts 
    myJob.NumWorkersRange = [num_workers, num_workers]; % set number of workers 
    task = createTask(myJob, @Grammar_Freq, 2, {threads(f,:,:),uniqueSeqs,t_one,t_two}); % Compress, return 2 outputs, input data 
    submit (myJob); % submit job 
        
end 
toc 

clear 