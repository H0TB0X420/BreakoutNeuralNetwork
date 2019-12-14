function y = LeakyReLU(x,scale)
  %y = max(0, x);
  y = x;
  y(x<0) = scale*x(y<0);
end