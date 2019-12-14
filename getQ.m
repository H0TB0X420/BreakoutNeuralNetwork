function [Q] = getQ(paddle, ball,direction,W1,W2,W3,W4)
%     x = zeros([Ni,1]);
    x = [paddle, ball(1), ball(2), direction(1), direction(2)]';
     
    % forward path
    % layer 1
    v1 = W1*x; %---> Add a row (val=1) for bias
    y1 = dReLU(v1);
    % layer 2
    v2 = W2*y1; %---> Add a row (val=1) for bias
    y2 = tanh(v2);
    % layer 3
    v3 = W3*y2; %---> Add a row (val=1) for bias
    y3 = dtanh(v3); 
    % layer 4
    v  = W4*y3; %---> Add a row (val=1) for bias
    Q  = Sigmoid(v);
     
     
     
end