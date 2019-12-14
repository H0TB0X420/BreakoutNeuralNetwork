function [W1,W2,W3,W4] = backprop_4layer(alpha, W1,W2,W3,W4,x,d)
     
 
    % single layer NN
    % E=-0.5*(d-y)^2
    % dE/dW=(dE/dy)*(dy/dW)=-(d-y)*x
    % wnew=wold-alpha*(dE/dW)
     
    %-------------Bias------------------------
    v1 = W1*x; %---> Add a row (val=1) for bias
    y1 = LeakyReLU(v1,0.25);
    % layer 2
    v2 = W2*y1; %---> Add a row (val=1) for bias
    y2 = LeakyReLU(v2,0.5);
    % layer 3
    v3 = W3*y2; %---> Add a row (val=1) for bias
    y3 = LeakyReLU(v3,0.75); 
    % layer 4
    v  = W4*y3; %---> Add a row (val=1) for bias
    y  = v;
    %-------------End Bias-----------------------
    e  = d - y;
    e = e([1 2 3]);
    delta = (dReLU(v).*e)';
  
    % layer 3
    e3     = W4*delta'; %---> exclude bias, dim(e1)=4
    delta3 = dtanh(v3).*e3;
    % layer 2
    e2     = W3'*delta3; %---> exclude bias, dim(e1)=4
    delta2 = Sigmoid(v2).*e2;
    % layer 1
    e1     = W2'*delta2; %---> exclude bias, dim(e1)=4
    delta1 = Softmax(v1).*e1;
     
    % weight update--------------------------------
    % layer 1
    dW1 = alpha*delta1*x'; %---> Add a column (val=1) for bias
    W1  = W1 + dW1;
    % layer 2
    dW2 = alpha*delta2*y1'; %---> Add a column (val=1) for bias
    W2  = W2 + dW2;
    % layer 3
    dW3 = alpha*delta3*y2'; %---> Add a column (val=1) for bias
    W3  = W3 + dW3;
    % layer 4
    dW4 = alpha*delta*y3; %---> Add a column (val=1) for bias
    W4  = W4 + dW4;
end