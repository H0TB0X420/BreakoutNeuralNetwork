% get Q(s,a): only for a=2 (continue)
% input x is column vector
function Qs = GetBias(score,W1,W2,W3,W4)
    x  = score; % input x is column vector
    
    v1 = W1*[x ; 1];
    y1 = LeakyReLU(v1,0.001); % y1 = ReLU(v1); % y1 = LeakyReLU(v1,0.001);
    
    v2 = W2*[y1 ; 1];
    y2 = LeakyReLU(v2,0.001); % y2 = ReLU(v2); % y2 = LeakyReLU(v2,0.001);
    
    v3 = W3*[y2 ; 1];
    y3 = LeakyReLU(v3,0.001); % y3 = ReLU(v3); % y3 = LeakyReLU(v3,0.001);
    
    v  = W4*[y3 ; 1];
    y  = v;
    
    Qs = y; % output Qs is column vector
end