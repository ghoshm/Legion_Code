% Compress_Grab

% Settings 
shuffles = 1 + 10; % hard coded number of data shuffles (+1 for real data) 

c = parcluster ('LegionGraceProfile'); % get a cluster object
jobs = findJob(c); % gets a list of jobs submitted to that cluster

% Allocate 
 grammar = cell(size(jobs,1),shuffles); % fish x test/control 
 compVec = cell(size(jobs,1),shuffles); % fish x test/control  
 totSavings = zeros(size(jobs,1),shuffles); % fish x test/control 
 gTermCell = cell(size(jobs,1),shuffles); % cell for storing n-grams
 q_time = zeros(size(jobs,1),1); % fish x 1 
 compression_time = zeros(size(jobs,1),1); % fish x 1 
 errors = []; % store fish who errored 
 
for j = 1:size(jobs,1) % for each job 
    
    try
    % Fetch Results 
    results = fetchOutputs(jobs(j)); 

    % Variables 
    grammar(j,:) =  results{1}; % take grammar 
    compVec(j,:) = results{2}; % take compressed vector 
    totSavings(j,:) = results{3}; % take savings 
    gTermCell(j,:) = results{4}; % take terminal grammar 
    
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

