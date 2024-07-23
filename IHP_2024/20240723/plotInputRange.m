filename = 'inputRange.csv';

Data = readmatrix(filename);

X = [0 : 0.2e-6 : 20e-6];
Y = [0 : 0.2e-6 : 20e-6];

figure;
xlim = [0 20e-6];
ylim = [0 20e-6];

surf(X, Y, Data);

hold on;

xlabel('Iin1');
ylabel('Iin2');
zlabel('out');
