% single episode
function [W1,W2,W3,W4] = RunEpisode(optype,score,Ni,Nh1,Nh2,Nh3,No,Na,W1,W2,W3,W4,alpha,gamma,epsilon)
    % instance of the breakout game
    breaker = breakout;
    [breaker] = breaker.new();
    result = 0;
    lB = 0;
    rB = 0;
    paddle = 0;
    ball = [0 , 0];
    direction = [0,0];
    
    % if result == 1 you either lost or won
    while result == 0
        Qs = getQ(paddle, ball, direction, W1,W2,W3,W4)';
        score
        
        action = ChooseAction([Q0s,Q1s],epsilon,Na,lB,rB);
        
        [breaker, paddleLoc, ballLoc, result, score, leftBound, rightBound] = breaker.update(action);
        lB = leftBound;
        rB = rightBound;
        
        maxQs1 = max(Qs);
        % Q-learning
        % update
        Qtarget = Qs;
        Qtarget(1,3) = 0;
        Qtarget(1,action) = (score*alpha)+gamma*maxQs1;
        x = zeros(Ni,1);
        x(action,1) = 1;
        % Q-learning with NN function approximation
        [W1,W2,W3,W4] = backprop_4layer(alpha,W1,W2,W3,W4,x,Qtarget');
    end
end