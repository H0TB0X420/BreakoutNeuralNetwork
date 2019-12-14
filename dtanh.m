function [dx] = dtanh(x)
    dx = 1-tanh(x).^2;
end