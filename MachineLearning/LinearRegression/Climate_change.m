%This script pertains to the Linear Regression Problem for Climate Change

data = csvread('climate_change.csv');
size(data)
data(1,:)
data(2,:)
data(309,:)
data = data(2:309, :);
data(1,:)

sum(isna(data))
printf('There are no missing values in the data')

logic = (data(:,1) < 2006);
train = data(logic, :)

logic = (data(:,1) >= 2006);
test = data(logic,:);

trainx = train(:,4:11);
trainy = train(:,3);

testx = test(:,4:11);
testy = test(:,3);

%Exploring data
for i = 1:8
  figure
  plot(train(:,i),trainy)
end;

%Cost Function Testing
theta = zeros(8,1);
costfunc(trainx, trainy, theta)

%Gradient Descent
GD(trainx, trainy, theta, 0.00001, 1500);
theta

%Checking Cost func

