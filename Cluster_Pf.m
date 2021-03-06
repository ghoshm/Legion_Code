% GMM Per Fish 
    % nanmean(q_time) = 1.8mins
    % nanmean(calc_time) = 20mins 
    % (max(calc_time))/60 = 67mins 
    
 % Settings 
c = parcluster ('LegionGraceProfile'); % Start a terminal session 
num_workers = 1; % specify number of workers 
load('Clustering_Test.mat'); % load data 
reps = 1; % set the number of repetitions
k_max = 1:20; % set values of k (clusters) to try
knee_dim = 3; % pca dimensions to keep  
options = statset('MaxIter',1000); % Hard coded number of iterations

X{1,1} = score(:,1:knee_dim); % active bouts 
X{2,1} = sleep_cells(:,3); % inactive bouts 

% Calculate Regularization
score_values = unique(X{1,1}(:)')'; % Find unique scores
score_zero = knnsearch(score_values,0); % Find the closest to zero
rv = abs(score_values(score_zero)); % Regularization value

tic 
for f = 578:max(fish_tags{1,1}) % for each fish 
    
   % submit fish seperately 
    Xf = cell(2,1); % allocate 
    Xf{1,1} = X{1,1}(fish_tags{1,1} == f,:); % active bouts 
    Xf{2,1} = X{2,1}(fish_tags{2,1} == f,:); % inactive bouts 
    myJob = createCommunicatingJob(c, 'Type', 'Pool'); % Create a cluster profile 
    myJob.AttachedFiles = {'GhoshMarcusModels.m'}; % required scripts 
    myJob.NumWorkersRange = [num_workers, num_workers]; % set number of workers 
    task = createTask(myJob, @GhoshMarcusModels, 5, {Xf,k_max,rv,options}); % Compress, return 4 outputs, input data 
    submit (myJob); % submit job 
        
end 
toc 

clear 