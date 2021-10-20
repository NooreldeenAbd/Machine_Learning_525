%%%% Initialize Patterns and OutPuts %%%%
P1 = transpose([1 -1 -1 -1 -1 1  -1 1 1 1 1 -1  -1 1 1 1 1 -1  -1 1 1 1 1 -1  1 -1 -1 -1 -1 1]);
P2 = transpose([1 1 1 1 1 1  -1 1 1 1 1 1  -1 -1 -1 -1 -1 -1  1 1 1 1 1 1  1 1 1 1 1 1]);
P3 = transpose([-1 1 1 1 1 1  -1 1 1 -1 -1 -1  -1 1 1 -1 1 -1  1 -1 -1 1 1 -1  1 1 1 1 1 -1]);
T1 = P1; T2 = P2; T3 = P3;

%%%% Randomly Reverse 3 pixels %%%%
P1Reverse = P1;
P2Reverse = P2;
P3Reverse = P3;

for i = 1:3
x = randi(30);
P1Reverse(x) = -1 * P1Reverse(x);
end
for i = 1:3
x = randi(30);
P2Reverse(x) = -1 * P2Reverse(x);
end
for i = 1:3
x = randi(30);
P3Reverse(x) = -1 * P3Reverse(x);
end

%%%% Normalize Everything %%%%
P1ReverseNorm = normc(P1Reverse); P1Norm = normc(P1);
P2ReverseNorm = normc(P2Reverse); P2Norm = normc(P2);
P3ReverseNorm = normc(P3Reverse); P3Norm = normc(P3);

%%%%% Hebbian Learning %%%%%
T = [T1 T2 T3];
P = [P1Norm P2Norm P3Norm];
Wh = T*(transpose(P));

%%%% Apply the Network and Display %%%%
a1h = Wh * P1ReverseNorm;
a2h = Wh * P2ReverseNorm;
a3h = Wh * P3ReverseNorm;

output1h = reshape(a1h,6,5);
output2h = reshape(a2h,6,5);
output3h = reshape(a3h,6,5);

figure('Name','Output1 H'),imshow(output1h, []);
figure('Name','Output2 H'),imshow(output2h, []);
figure('Name','Output3 H'),imshow(output3h, []);

%%%% Correlation table 1 %%%%
fprintf('Table 1: Using Hebbian Learning Rule \n');
fprintf('          |Output 1|Output 2|Output 3|\n');
fprintf('-------------------------------------------------------\n');
fprintf('Pattern 1 |%*f|%f|%f|\n', 8,abs(corr2(P1,a1h)),abs(corr2(P1,a2h)),abs(corr2(P1,a3h)));
fprintf('Pattern 2 |%*f|%f|%f|\n', 8,abs(corr2(P2,a1h)),abs(corr2(P2,a2h)),abs(corr2(P2,a3h)));
fprintf('Pattern 3 |%*f|%f|%f|\n', 8,abs(corr2(P3,a1h)),abs(corr2(P3,a2h)),abs(corr2(P3,a3h)));
fprintf('\n\n');


%%%%% Again with Pseudo-Inverse %%%%%
PInverse = (transpose(P)*P) \ transpose(P);
Wi = T*PInverse;

a1i = Wi * P1ReverseNorm;
a2i = Wi * P2ReverseNorm;
a3i = Wi * P3ReverseNorm;

output1i = reshape(a1h,6,5);
output2i = reshape(a2h,6,5);
output3i = reshape(a3h,6,5);

figure('Name','Output1 I'),imshow(output1i, []);
figure('Name','Output2 I'),imshow(output2i, []);
figure('Name','Output3 I'),imshow(output3i, []);

%%%% Correlation table 2 %%%%
fprintf('Table 2: Using Pseudo Inverse \n');
fprintf('          |Output 1|Output 2|Output 3|\n');
fprintf('-------------------------------------------------------\n');
fprintf('Pattern 1 |%*f|%f|%f|\n', 8,abs(corr2(P1,a1i)),abs(corr2(P1,a2i)),abs(corr2(P1,a3i)));
fprintf('Pattern 2 |%*f|%f|%f|\n', 8,abs(corr2(P2,a1i)),abs(corr2(P2,a2i)),abs(corr2(P2,a3i)));
fprintf('Pattern 3 |%*f|%f|%f|\n', 8,abs(corr2(P3,a1i)),abs(corr2(P3,a2i)),abs(corr2(P3,a3i)));
fprintf('\n\n');

