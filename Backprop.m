%
% back propagation for a SINGLE observation
%
% "simple multi-layer neural network"
%
% (input layer (Ni nodes) -> hidden layer (Nh nodes)-> output layer (No nodes)
% W1 is Nh by Ni matrix (wij is weight for hidden node i from input node j)
% W2 is No by Nh matrix (wij is weight for output node i from hidden node j)
% X is input COLUMN vector of Ni by 1
% D is output COLUMN vector of No by 1
%
% type  1: basic backprop
%       2: momentum
%       3: cross-entropy
%       4: softmax
%
% alpha  : learning rate in updating weights
%
 
function [W1] = Backprop(W1,x,d)
     
    alpha = 0.1;
 
    % single layer NN
    % E=-0.5*(d-y)^2
    % dE/dW=(dE/dy)*(dy/dW)=-(d-y)*x
    % wnew=wold-alpha*(dE/dW)
        
    v = W1*x;
    y = v;
    e = d - y;
         
    delta = e;
    dW1 = alpha*delta*x';
    W1  = W1 + dW1;
end