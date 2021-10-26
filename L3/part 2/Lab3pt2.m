% Read all letters.
Pa = double(imread('char1_a.bmp')); Pa = reshape(Pa, numel(Pa), 1);
Pb = double(imread('char1_b.bmp')); Pb = reshape(Pb, numel(Pb), 1);
Pc = double(imread('char1_c.bmp')); Pc = reshape(Pc, numel(Pc), 1);
Pd = double(imread('char1_d.bmp')); Pd = reshape(Pd, numel(Pd), 1);
Pe = double(imread('char1_e.bmp')); Pe = reshape(Pe, numel(Pe), 1);
Pf = double(imread('char1_f.bmp')); Pf = reshape(Pf, numel(Pf), 1);
Pg = double(imread('char1_g.bmp')); Pg = reshape(Pg, numel(Pg), 1);
Ph = double(imread('char1_h.bmp')); Ph = reshape(Ph, numel(Ph), 1);
Pi = double(imread('char1_i.bmp')); Pi = reshape(Pi, numel(Pi), 1);
Pj = double(imread('char1_j.bmp')); Pj = reshape(Pj, numel(Pj), 1);
Pk = double(imread('char1_k.bmp')); Pk = reshape(Pk, numel(Pk), 1);
Pl = double(imread('char1_l.bmp')); Pl = reshape(Pl, numel(Pl), 1);
Pm = double(imread('char1_m.bmp')); Pm = reshape(Pm, numel(Pm), 1);
Pn = double(imread('char1_n.bmp')); Pn = reshape(Pn, numel(Pn), 1);
Po = double(imread('char1_o.bmp')); Po = reshape(Po, numel(Po), 1);
Pp = double(imread('char1_p.bmp')); Pp = reshape(Pp, numel(Pp), 1);
Pq = double(imread('char1_q.bmp')); Pq = reshape(Pq, numel(Pq), 1);
Pr = double(imread('char1_r.bmp')); Pr = reshape(Pr, numel(Pr), 1);
Ps = double(imread('char1_s.bmp')); Ps = reshape(Ps, numel(Ps), 1);
Pt = double(imread('char1_t.bmp')); Pt = reshape(Pt, numel(Pt), 1);
Pu = double(imread('char1_u.bmp')); Pu = reshape(Pu, numel(Pu), 1);
Pv = double(imread('char1_v.bmp')); Pv = reshape(Pv, numel(Pv), 1);
Pw = double(imread('char1_w.bmp')); Pw = reshape(Pw, numel(Pw), 1);
Px = double(imread('char1_x.bmp')); Px = reshape(Px, numel(Px), 1);
Py = double(imread('char1_y.bmp')); Py = reshape(Py, numel(Py), 1);
Pz = double(imread('char1_z.bmp')); Pz = reshape(Pz, numel(Pz), 1);

%%%%% Normalized Original Images%%%%%
PaN = normc(Pa); PbN = normc(Pb); PcN = normc(Pc); PdN = normc(Pd); PeN = normc(Pe);
PfN = normc(Pf); PgN = normc(Pg); PhN = normc(Ph); PiN = normc(Pi); PjN = normc(Pj);
PkN = normc(Pk); PlN = normc(Pl); PmN = normc(Pm); PnN = normc(Pn); PoN = normc(Po);
PpN = normc(Pp); PqN = normc(Pq); PrN = normc(Pr); PsN = normc(Ps); PtN = normc(Pt);
PuN = normc(Pu); PvN = normc(Pv); PwN = normc(Pw); PxN = normc(Px); PyN = normc(Py);
PzN = normc(Pz);

P = [PaN PbN PcN PdN PeN PfN PgN PhN PiN PjN PkN PlN PmN PnN PoN PpN PqN PrN PsN PtN PuN PvN PwN PxN PyN PzN];
T = P;

W = zeros(numel(Pa), numel(Pa));
b = zeros(numel(Pa, 1));

%Display Input
figure(1);
for n = 1:26
    nexttile;
    imshow(reshape(P(:,n),[20 20]),[]); 
    title(n);
    hold;
end
hold off;

%Apply the LMS Algorithm
R = transpose(P)*P;
LearningRate = 1/(10*max(eigs(R)));
errors = zeros(1,100000); 
ErrorThreshold = 1*10^-6;
errors (1) = 1;

j = 1;
while errors(j) > ErrorThreshold
    err = zeros(400,26);
    
    for k = 1 : 26
        err(:,k) = T(:,k) - purelin(W*P(:,k) + b);
        W = W + 2 * LearningRate * err(:,k) * transpose(P(:,k));
        b = b + 2 * LearningRate * err(:,k);
    end
    
    errors(j+1) = mse(err);
    j = j+1;
end

% Show learning curve
figure, semilogy(errors)
xlabel('iterations');
ylabel('mean square error');
hold off;

%Show a few Outputs
output = zeros(400,26);
figure(3);
 for n = 1:3
     nexttile;
     output(:,n) = purelin(W * P(:,n) + b);
     imshow(reshape(output(:,n),[20 20]), []);
     title(n);
     hold;
 end
  hold off;
  

% Correlation table
letters = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
fprintf(' |a        b        b        d        e        f        g        h        i        j        k        l        m        n        o        p        q        r        s        t        u        v        w        x        y        z\n')
fprintf('-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n')
for i = 1: 26
    fprintf('%c', letters(i))
    curimg = P(:,i);
    fprintf('|%*f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f\n',4,abs(corr2(W*curimg,Pa)),abs(corr2(W*curimg,Pb)),abs(corr2(W*curimg,Pc)),abs(corr2(W*curimg,Pd)),abs(corr2(W*curimg,Pe)),abs(corr2(W*curimg,Pf)),abs(corr2(W*curimg,Pg)),abs(corr2(W*curimg,Ph)),abs(corr2(W*curimg,Pi)),abs(corr2(W*curimg,Pj)),abs(corr2(W*curimg,Pk)),abs(corr2(W*curimg,Pl)),abs(corr2(W*curimg,Pm)),abs(corr2(W*curimg,Pn)),abs(corr2(W*curimg,Po)),abs(corr2(W*curimg,Pp)),abs(corr2(W*curimg,Pq)),abs(corr2(W*curimg,Pr)),abs(corr2(W*curimg,Ps)),abs(corr2(W*curimg,Pt)),abs(corr2(W*curimg,Pu)),abs(corr2(W*curimg,Pv)),abs(corr2(W*curimg,Pw)),abs(corr2(W*curimg,Px)),abs(corr2(W*curimg,Py)),abs(corr2(W*curimg,Pz)));
end