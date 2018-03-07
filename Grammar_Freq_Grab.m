% Grammar_Freq_Grab 

% Settings 
shuffles = 1 + 10; % hard coded number of data shuffles (+1 for real data) 

c = parcluster ('LegionGraceProfile'); % get a cluster object
jobs = findJob(c); % gets a list of jobs submitted to that cluster

% Allocate 
 gCount = cell(size(jobs,1),shuffles); % fish x test & controls 
 gCount_norm = cell(size(jobs,1),1); % fish x 1 
 q_time = zeros(size(jobs,1),1); % fish x 1 
 calc_time = zeros(size(jobs,1),1); % fish x 1 
 errors = []; % store fish who errored 
 
for j = 1:size(jobs,1) % for each job 
    
    try
    % Fetch Results 
    results = fetchOutputs(jobs(j)); 

    % Variables 
    gCount(j,:) =  results{1}; % take counts 
    gCount_norm(j,:) = results{2}; % take normalised counts 
    
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