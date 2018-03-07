% Batch Test 

 c = parcluster ('LegionGraceProfile'); % Start a terminal session 
 num_workers = 1; 
    
for f = 1:2 
   
    myJob = createCommunicatingJob(c, 'Type', 'Pool'); % Create a cluster profile 
    myJob.AttachedFiles = {'Test.m'}; 
    myJob.NumWorkersRange = [num_workers, num_workers];
    task = createTask(myJob, @Test, 1, {f});
    submit (myJob); 
        
end 