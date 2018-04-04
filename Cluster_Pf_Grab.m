% Cluster_Pf Grab

% Settings 
k_max = 1:20; % set values of k (clusters) to try
c = parcluster ('LegionGraceProfile'); % get a cluster object
jobs = findJob(c); % gets a list of jobs submitted to that cluster

% Allocate 
BIC{1,1} = nan(size(jobs,1),k_max(end),'single'); % fish x clusters fit 
BIC{2,1} = nan(size(jobs,1),k_max(end),'single'); % fish x clusters fit 
q_time = zeros(size(jobs,1),1); % fish x 1 
calc_time = zeros(size(jobs,1),1); % fish x 1 
errors = []; % store fish who errored 
 
for j = 1:size(jobs,1) % for each job 
    
    try
    % Fetch Results 
    results = fetchOutputs(jobs(j)); 

    % Variables 
    BIC{1,1}(j,:) =  results{1,4}(1,:); % take active BIC 
    BIC{2,1}(j,:) =  results{1,4}(2,:); % take inactive BIC 

    % Timings 
    q_time(j,1) = minutes(jobs(j).StartDateTime - jobs(j).SubmitDateTime); % queue time (mins)
    calc_time(j,1) = minutes(jobs(j).FinishDateTime - jobs(j).StartDateTime); % compression time (mins) 
        
    catch 
        errors = [errors j]; % keep track of fish who didn't return outputs 
    end
    
    clear results
    disp(horzcat('Collected Data for fish ',num2str(j),' of ',num2str(size(jobs,1)))); 
    
end 

clear c jobs j 

save('/scratch/scratch/zchahp0/Matlab_remote_jobs/Results.mat','-v7.3'); % save workspace
