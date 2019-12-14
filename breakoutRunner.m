function breakoutRunner()
    % learning rate: slow learning makes Q-curve smoother (<0.005)
    alpha = 0.15;
    % discount rate: option value becomes more distinct for large discount
    gamma = 0.95;
    % epsilon-greedy search: need sufficiently large exploration (>0.2)
    epsilon = 0.3;
    % 1 = right, 2 = left, 3 = stay
    optype = 1;
    % number of actions
    Na = 3;
    % number of input nodes
    Ni = 1; % {s}
    % number of output nodes
    No = 1; % q(s,action}
    % number of hidden layers
    Nh1 = 10;
    Nh2 = 10;
    Nh3 = 10;
    
    % initialize weighting matrices
    % Q for action=1
    W1 = 2*rand(Nh1,Ni+1)-1; % add one column for bias
    W2 = 2*rand(Nh2,Nh1+1)-1; % add one column for bias
    W3 = 2*rand(Nh3,Nh2+1)-1; % add one column for bias
    W4 = 2*rand(No,Nh3+1)-1; % add one column for bias
    
    % run through episodes
     Ne = 50;
     for i = 1:Ne
         score = 0;
         [W1,W2,W3,W4] = RunEpisode(optype,score,Ni,Nh1,Nh2,Nh3,No,Na,W1,W2,W3,W4,alpha,gamma,epsilon);
     end
end