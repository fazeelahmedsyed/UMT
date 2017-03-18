%Cost function
function J = costfunc(X,y,theta)

m = length(y);
J = 0;
SSE = sum((X*theta - y).^2);
J = (1/(2*m))*SSE

end;