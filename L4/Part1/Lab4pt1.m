%Generating chaotic data sequence
p = zeros(200,1);
p(1) = 0.35;
for i = 2:200
    p(i) = 4*p(i-1)*(1-p(i-1));
end

%Initializing 
lr = 0.1;
err_t = 0.015;

w1 = randn(5,2);
w2 = randn(1,5);
b1 = randn(5,1);
b2 = randn();

a1 = zeros(1,5);
a2 = 0;

z = 1;
err = zeros(1,1000);
err(1) = 1;

%Applying BackPropogation Algo
while err(z) > err_t
    e = zeros(1,188);
    
    %Calculate outputs
    for j = 1:190
        a0 = [p(j+1) ; p(j)];
        a1 = logsig(w1 * a0 + b1);
        a2 = w2 * a1 + b2;
        e(j) = p(j+2) - a2;
        
        F1 = eye(5);
        for k = 1:5
            F1(k,k) = (1-a1(k))*a1(k);
        end
        %Update sensitivity
        F2 = 1;
        s2 = -2 * F2*e(j);
        s1 = F1*transpose(w2)*s2;
        
        %Update Weights and biases
        w2 = w2 - lr*s2*transpose(a1);
        b2 = b2 - lr*s2;
        w1 = w1 - lr*s1*transpose(a0);
        b1 = b1 - lr*s1;    
    end
    z = z + 1;
    %Update MSE
    err(z) = mse(e);
    disp(mse(e));
end   

%Error rate vs iterations
figure(1);
semilogy(err(2:1000));
xlabel('iterations');
ylabel('mean square error');


%Expected Vs predicted values (last 10)
  at190_200 = zeros(1,11);
  for i = 1:11
        a1 = logsig(w1 * [p(i+188) ; p(i + 187)] + b1);
        at190_200(i) = w2 * a1 + b2;
  end
 
figure(2);
plot(at190_200);
hold on;
plot(p(190:200));
hold off;


at = zeros(1,200);
  for i = 1:197
        a1 = logsig(w1 * [p(i+1) ; p(i)] + b1);
        at(i) = w2 * a1 + b2;
  end

figure(3);
plot(p(3:200));
hold on;
plot(at);
hold on;

