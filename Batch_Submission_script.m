% Batch Submission Script 

for k = 13:15% For K clusters 
    c = parcluster ('LegionGraceProfile'); % Start a terminal session 
    myJob = createCommunicatingJob (c, 'Type', 'Pool'); % Create a cluster profile 
    num_workers = 12; 
    load('Wake_cells_2d.mat'); 
    myJob.AttachedFiles = {'GhoshMarcusModels.m'}; 
    myJob.NumWorkersRange = [num_workers, num_workers];
    task = createTask(myJob, @GhoshMarcusModels, 6, {X, k});
    submit (myJob); 
    
    clear c myJob num_workers X task 
end 

clear k 