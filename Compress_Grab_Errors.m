% Compress_Grab_Errors

c = parcluster ('LegionGraceProfile'); % get a cluster object
jobs = findJob(c); % gets a list of jobs submitted to that cluster

% Load Data 
load('Results.mat'); % load correct data  
disp('Loaded Results Data'); % report on slow loading 

% Start a counter 
counter = size(grammar,1) + 1; % start one higher than the size of your data  
 
% Fill in data for the fish who errored 
errors_2 = []; % keep track of fish who didn't return outputs again... 
for j = errors % for each fish who errored  
    
    try
    % Fetch Results 
    results = fetchOutputs(jobs(counter)); 

    % Variables 
    grammar(j,:) =  results{1}; % take grammar 
    compVec(j,:) = results{2}; % take compressed vector 
    totSavings(j,:) = results{3}; % take savings 
    gTermCell(j,:) = results{4}; % take terminal grammar 
    
    % Timings 
    q_time(j,1) = minutes(jobs(counter).StartDateTime - jobs(counter).SubmitDateTime); % queue time (mins)
    compression_time(j,1) = minutes(jobs(counter).FinishDateTime - jobs(counter).StartDateTime); % compression time (mins) 
        
    catch 
        errors_2 = [errors_2 j]; % track fish who errored again...
    end
    
    clear results    
    counter = counter + 1; % add to counter 
    
end 

clear c jobs j counter 

save('/scratch/scratch/zchahp0/Matlab_remote_jobs/Results_Final.mat','-v7.3'); % save workspace
