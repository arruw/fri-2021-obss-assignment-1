clear;
clf;

record = 's20501m.mat';
% record = '../data/physionet.org/files/mitdb/1.0.0/100m.mat';

m = 5;

x = load(record).val(2,:);

% M point moving average
y1 = filter(1/m*ones(1,m), 1, x);

% delay ????
y2 = filter([zeros(1, (m-1)/2), [(m+1)/2]], 1, x);

y = y2 - y1;
% y = x - y1;

z = movsum(y.^2, 30);

[pks, loc] = findpeaks(z, 'MinPeakDistance', 120);

alpha = 0.05;
gamma = 0.15;
t = filter([1-alpha, alpha*gamma], 1, pks);

beats_x = loc(pks > t);
beats_y = x(beats_x);

yyaxis left;
plot(x);
hold on;
%hold on;
%plot(loc, t);
for i = 1:size(beats_x, 2)
    xline(beats_x(i), '--');
end
hold off;       





% Threshold = alfa * gama * PEAK + (1 - alfa) * Threshold
