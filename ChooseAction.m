% choose action based on epsilon greedy strategy
% input
%   Qs - choice of Q(s,:) at state s
%   Na - number of action choices
%   epsilon - small number used to go off in random direction occasionally
%   amax - action that maximizes reward
%   Qsmax - action
function [action] = ChooseAction(Qs,epsilon,Na,lB,rB)
    % greedy action choice: choose action that maximize Q(s,a)
    [Qsmax,amax] = max(Qs);
    
    % epsilon-greedy exploration
    action = amax % exploit: Q-maximizing greedy policy
    
    if rand(1)<epsilon % explore
        while action == amax  % pick random integer (1~Na) other than amax
            action = randi(Na)
        end
    end
    
    if lB == 1
        action = 1;
    elseif rB == 1
        action = 2;
    end
end
