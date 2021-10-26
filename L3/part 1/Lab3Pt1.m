%Initiallize Data and Starting Points 
P = [1 1 2 2 -1 -2 -1 -2; 1 2 -1 0 2 1 -1 -2];
T = [-1 -1 -1 -1 1 1 1 1;-1 -1 1 1 -1 -1 1 1];

W = [0 0 ; 0 0];
b = [0 ; 0];

%Apply the LMS Algorithm
R = transpose(P)*P;
LearningRate = 1/(10*max(eigs(R)));
errors = zeros(1,5000); 
ErrorThreshold = 1*10^-6;
errors (1) = 1;
errDiff = errors(1) - errors(2);

j = 1;
while errDiff > ErrorThreshold
    err = zeros(2,8);
    
    for k = 1 : 8
        err(:,k) = T(:,k) - purelin(W*P(:,k) + b);
        W = W + 2 * LearningRate * err(:,k) * transpose(P(:,k));
        b = b + 2 * LearningRate * err(:,k);
    end
    
    errors(j) = mse(err);
    
    if (j == 1)
        errDiff = 1;
    else
        errDiff = errors(j-1) - errors(j);
    end
    j = j+1;
end

% Show learning curve
figure, semilogy(errors)
xlabel('iterations');
ylabel('mean square error');

% Correlation table
target = [-1 -1 1 1; -1 1 -1 1];
sq_err = zeros(4,8);

for k = 1:4
    for i = 1:8
        a = W * P(:,i) + b;
        sq_err(k,i) = mse(target(:,k) - a);
    end
end

fprintf('      |P1          |P2          |P3          |P4          |P5          |P6          |p7          |p8\n')
fprintf('---------------------------------------------------------------------------------------------------------\n')

for k = 1:4
    fprintf('T%d    ',k);
    for i = 1:8
       fprintf('%f     ',sq_err(k,i));
    end
    fprintf('\n')
end
