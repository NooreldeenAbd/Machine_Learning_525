
%%%% ReadImages %%%%
P1 = double(imread('AudreyHepburn.jpg'));
P2 = double(rgb2gray(imread('BillGates.jpg')));
P3 = double(rgb2gray(imread('MrWhite.jpg')));
P4 = double(rgb2gray(imread('SheldonCooper.jpg')));
P5 = double(rgb2gray(imread('TaylorSwift.jpg')));


%%%%% Put Original Images in a Single Column %%%%%
P1Orig = reshape(P1, numel(P1), 1);
P2Orig = reshape(P2, numel(P2), 1);
P3Orig = reshape(P3, numel(P3), 1);
P4Orig = reshape(P4, numel(P4), 1);
P5Orig = reshape(P5, numel(P5), 1);
T1 = P1Orig; T2 = P2Orig; T3 = P3Orig; 
T4 = P4Orig; T5 = P5Orig;

%%%% Normalize Original %%%%
P1OrigNorm = normc(P1Orig);
P2OrigNorm = normc(P2Orig);
P3OrigNorm = normc(P3Orig);
P4OrigNorm = normc(P4Orig);
P5OrigNorm = normc(P5Orig);

%%%% Add 20dB %%%%
P1Noise = awgn(P1Orig, 20, 'measured');
P2Noise = awgn(P2Orig, 20, 'measured');
P3Noise = awgn(P3Orig, 20, 'measured');
P4Noise = awgn(P4Orig, 20, 'measured');
P5Noise = awgn(P5Orig, 20, 'measured');

%%%% Normalize Noisy Image %%%%
P1NoiseNorm = normc(P1Noise);
P2NoiseNorm = normc(P2Noise);
P3NoiseNorm = normc(P3Noise);
P4NoiseNorm = normc(P4Noise);
P5NoiseNorm = normc(P5Noise);


%%%%% Hebbian Learning %%%%%
T = [T1 T2 T3 T4 T5];
P = [P1OrigNorm P2OrigNorm P3OrigNorm P4OrigNorm P5OrigNorm];
Wh = T*(transpose(P));

%%%% Apply the Network and Display %%%%
a1h = Wh * P1NoiseNorm;
a2h = Wh * P2NoiseNorm;
a3h = Wh * P3NoiseNorm;
a4h = Wh * P4NoiseNorm;
a5h = Wh * P5NoiseNorm;

figure, imshow(mat2gray(reshape(a1h, [75 75])));
figure, imshow(mat2gray(reshape(a2h, [75 75])));
figure, imshow(mat2gray(reshape(a3h, [75 75])));
figure, imshow(mat2gray(reshape(a4h, [75 75])));
figure, imshow(mat2gray(reshape(a5h, [75 75])));


%%%% Correlation table 1 %%%%
fprintf('Table 1: Using Hebbian Learning Rule \n');
fprintf('          |Output 1|Output 2|Output 3|Output 4|Output 5\n');
fprintf('-------------------------------------------------------\n');


fprintf('Pattern 1 |%*f|%f|%f|%f|%f\n', 8,abs(corr2(P1Orig,a1h)),abs(corr2(P1Orig,a2h)),abs(corr2(P1Orig,a3h)),abs(corr2(P1Orig,a4h)),abs(corr2(P1Orig,a5h)));
fprintf('Pattern 2 |%*f|%f|%f|%f|%f\n', 8,abs(corr2(P2Orig,a1h)),abs(corr2(P2Orig,a2h)),abs(corr2(P2Orig,a3h)),abs(corr2(P2Orig,a4h)),abs(corr2(P2Orig,a5h)));
fprintf('Pattern 3 |%*f|%f|%f|%f|%f\n', 8,abs(corr2(P3Orig,a1h)),abs(corr2(P3Orig,a2h)),abs(corr2(P3Orig,a3h)),abs(corr2(P3Orig,a4h)),abs(corr2(P3Orig,a5h)));
fprintf('Pattern 4 |%*f|%f|%f|%f|%f\n', 8,abs(corr2(P4Orig,a1h)),abs(corr2(P4Orig,a2h)),abs(corr2(P4Orig,a3h)),abs(corr2(P4Orig,a4h)),abs(corr2(P4Orig,a5h)));
fprintf('Pattern 5 |%*f|%f|%f|%f|%f\n', 8,abs(corr2(P5Orig,a1h)),abs(corr2(P5Orig,a2h)),abs(corr2(P5Orig,a3h)),abs(corr2(P5Orig,a4h)),abs(corr2(P5Orig,a5h)));
fprintf('\n\n');


%%%% Again with Pseudo-Inverse %%%%%
PInverse = (transpose(P)*P) \ transpose(P);
Wi = T*PInverse;

a1i = Wi * P1NoiseNorm;
a2i = Wi * P2NoiseNorm;
a3i = Wi * P3NoiseNorm;
a4i = Wi * P4NoiseNorm;
a5i = Wi * P5NoiseNorm;


figure, imshow(reshape(a1i, [75 75]), [0 255]);
figure, imshow(reshape(a2i, [75 75]), [0 255]);
figure, imshow(reshape(a3i, [75 75]), [0 255]);
figure, imshow(reshape(a4i, [75 75]), [0 255]);
figure, imshow(reshape(a5i, [75 75]), [0 255]);


%%%% Correlation table 2 %%%%
fprintf('Table 2: Using Pseudo Inverse \n');
fprintf('          |Output 1|Output 2|Output 3|Output 4|Output 5\n');
fprintf('-------------------------------------------------------\n');
fprintf('Pattern 1 |%*f|%f|%f|%f|%f\n', 8,abs(corr2(P1Orig,a1i)),abs(corr2(P1Orig,a2i)),abs(corr2(P1Orig,a3i)),abs(corr2(P1Orig,a4i)),abs(corr2(P1Orig,a5i)));
fprintf('Pattern 2 |%*f|%f|%f|%f|%f\n', 8,abs(corr2(P2Orig,a1i)),abs(corr2(P2Orig,a2i)),abs(corr2(P2Orig,a3i)),abs(corr2(P2Orig,a4i)),abs(corr2(P2Orig,a5i)));
fprintf('Pattern 3 |%*f|%f|%f|%f|%f\n', 8,abs(corr2(P3Orig,a1i)),abs(corr2(P3Orig,a2i)),abs(corr2(P3Orig,a3i)),abs(corr2(P3Orig,a4i)),abs(corr2(P3Orig,a5i)));
fprintf('Pattern 4 |%*f|%f|%f|%f|%f\n', 8,abs(corr2(P4Orig,a1i)),abs(corr2(P4Orig,a2i)),abs(corr2(P4Orig,a3i)),abs(corr2(P4Orig,a4i)),abs(corr2(P4Orig,a5i)));
fprintf('Pattern 5 |%*f|%f|%f|%f|%f\n', 8,abs(corr2(P5Orig,a1i)),abs(corr2(P5Orig,a2i)),abs(corr2(P5Orig,a3i)),abs(corr2(P5Orig,a4i)),abs(corr2(P5Orig,a5i)));
fprintf('\n\n');
