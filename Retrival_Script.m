% Retrival Script

% Hard Coded Variables 
%jobs_to_grab = [41 32:40 42:46]; % Sleep 
jobs_to_grab = [16:27]; % Wake
disp(horzcat('Number of Jobs = ',num2str(size(jobs_to_grab,2)))); 

% Soft Coded Variables 
num_clusters = size(jobs_to_grab,2); % Determine number of clusters 
%Sleep.GMModels = cell(num_clusters,1); % Pre-allocate
Wake.AIC = zeros(1,num_clusters); % Pre-allocate
Wake.BIC = zeros(1,num_clusters); % Pre-allocate
Wake.idx = cell(num_clusters,1); % Pre-allocate
Wake.nlogl = cell(num_clusters,1); % Pre-allocate
Wake.P = cell(num_clusters,1); % Pre-allocate 

% Cluster Profile 
c = parcluster('LegionGraceProfile'); % Get Cluster object 
jobs = findJob(c); % Find cluster jobs 

% Merge data 
counter = 1; % start a counter 
for k = jobs_to_grab % For each cluster 
    clear job results; 
    
    job = jobs(k); % load data
    results = fetchOutputs(job); % Fetch funciton outputs 
    
    % Save outputs
    %Sleep.GMModels{counter,1} = results{1}(counter,1); 
    Wake.AIC(counter) = results{2}(1,counter); 
    Wake.BIC(counter) = results{3}(1,counter); 
    
    if counter == 1
        Wake.idx{counter,1} = results{4}{1};
        Wake.nlogl{counter,1} = results{5}{1};
        Wake.P{counter,1} = results{6}{1};
    else
        Wake.idx{counter,1} = results{4}{counter,1};
        Wake.nlogl{counter,1} = results{5}{counter,1};
        Wake.P{counter,1} = results{6}{counter,1};
    end
    
    disp(horzcat('Grabbed Job ',num2str(counter))); % Report progress 
    counter = counter + 1; % add to counter 
    
end 

clearvars -except Wake