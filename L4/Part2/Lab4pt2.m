
load('LAB4_p2.mat');

err_t = 0.00002;
lr = 0.05;

w1 = randn(5,2);
w2 = randn(1,5);
b1 = randn(5,1);
b2 = randn();

a1 = zeros(1,5);
a2 = 0;

z = 1;
err = zeros(1,1000);
err(1) = 1;
while err(z) > err_t
    e = zeros(1,168);
    for j = 1:170
        a0 = [p(j+1) ; p(j)];
        a1 = logsig(w1 * a0 + b1);
        a2 = w2 * a1 + b2;
        e(j) = p(j+2) - a2;
        
        F1 = eye(5);
        for k = 1:5
            F1(k,k) = (1-a1(k))*a1(k);
        end
        F2 = 1;
        s2 = -2 * F2*e(j);
        s1 = F1*transpose(w2)*s2;

        w2 = w2 - lr*s2*transpose(a1);
        b2 = b2 - lr*s2;
        w1 = w1 - lr*s1*transpose(a0);
        b1 = b1 - lr*s1;
    end
    z = z + 1;
    err(z) = mse(e);
    disp(mse(e));
end   

figure(1);
semilogy(err(2:1000));
xlabel('iterations');
ylabel('mean square error');

at170_180 = zeros(1,11);
  for i = 1:11
     a1 = logsig(w1 * [p(i+168) ; p(i+167)] + b1);
     at170_180(i) = purelin(w2 * a1 + b2);  
  end
 
figure(2);
plot(at170_180);
hold on;
plot(p(170:180));
hold off;

at = zeros(1,180);
  for i = 1:177
     a1 = logsig(w1 * [p(i+1) ; p(i)] + b1);
     at(i) = purelin(w2 * a1 + b2);  
  end

figure(3);
plot(p(3:180));
hold on;
plot(at);
hold off;