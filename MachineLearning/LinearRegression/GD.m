%GD

function [theta, J_history] = GD(X,y, theta, alpha, iterations)
  m = length(y);
  J_history = zeros(iterations,1);
  for i = 1:iterations
    delta = 1/m*(((X*theta)- y)'*X)';
    theta = theta - alpha.*delta;
    J_history(iterations) = costfunc(X,y,theta);
  end;
end;
  