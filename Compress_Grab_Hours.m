% Compress_Grab Per Hour 

% Settings 
shuffles = 1 + 10; % hard coded number of data shuffles (+1 for real data) 
hours = 48; % hard coded maximum number of time windows  

c = parcluster ('LegionGraceProfile'); % get a cluster object
jobs = findJob(c); % gets a list of jobs submitted to that cluster

% Allocate
 totSavings = zeros(size(jobs,1),hours,shuffles); % fish x time windows x test/control 
 q_time = zeros(size(jobs,1),1); % fish x 1 
 compression_time = zeros(size(jobs,1),1); % fish x 1 
 errors = []; % store fish who errored 
 
for j = 1:size(jobs,1) % for each job 
    
    try
    % Fetch Results 
    results = fetchOutputs(jobs(j)); 

    % Variables 
    totSavings(j,1:size(results{1},2),:) = results{1}; % take savings 
    
    % Timings 
    q_time(j,1) = minutes(jobs(j).StartDateTime - jobs(j).SubmitDateTime); % queue time (mins)
    compression_time(j,1) = minutes(jobs(j).FinishDateTime - jobs(j).StartDateTime); % compression time (mins) 
        
    catch 
        errors = [errors j]; % keep track of fish who didn't return outputs 
    end
    
    clear results
    disp(horzcat('Collected Data for fish ',num2str(j),' of ',num2str(size(jobs,1)))); 
    
end 

clear c jobs j 

save('/scratch/scratch/zchahp0/Matlab_remote_jobs/Results.mat','-v7.3'); % save workspace
