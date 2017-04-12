function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%
%Creating labels for different classes of y and isolating the indices
pass = find(y==1);
fail = find(y==0);

%Creating points for passing students
plot(X(pass,1),X(pass,2), 'r+', 'Linewidth', 2, 'Markersize', 7);

#Creating points for failing students
plot(X(fail,1),X(fail,2), 'go', 'Linewidth', 2, 'Markersize',7);









% =========================================================================



hold off;

end
