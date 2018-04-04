function [GMModels,idx,P,BIC,AIC] = GhoshMarcusModels(Xf,k_max,rv,options)

% allocate 
GMModels = cell(2,k_max(end)); % models 
idx = cell(2,k_max(end)); % cluster assignments 
P = cell(2,k_max(end)); % posterior probabilities 
BIC = zeros(2,k_max(end),'single'); % info criteria 
AIC = zeros(2,k_max(end),'single'); % info criteria 


% Loop
for s = 1:2 % for active/inactive 
    
    for k = k_max % for each clustering 

        GMModels{s,k} = fitgmdist(Xf{s,1},k,...
            'Options',options,'RegularizationValue',...
            rv,'Replicates',5); % Fit K gaussians
        
        [idx{s,k},~,P{s,k}] = cluster(GMModels{s,k},Xf{s,1});
        P{s,k} = max(P{s,k},[],2); % Keep only assigned probabilities (helps memory)
        
        % Information Criteria
        BIC(s,k)= GMModels{s,k}.BIC; % Extract BIC
        AIC(s,k)= GMModels{s,k}.AIC; % Extract AIC

    end
    
end

end
 