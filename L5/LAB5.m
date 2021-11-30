F_C = readfis('Gear_Selection_C.fis');
F_M = readfis('Gear_Selection_M.fis');
F_L = readfis('Gear_Selection_L.fis');

X = [ 15 -12 ; 80 5 ; 45 0 ; 21 10 ; 75 -3];

Y_Cent = evalfis(F_C,X)
Y_MOM = evalfis(F_M,X)
Y_LOM = evalfis(F_L,X)