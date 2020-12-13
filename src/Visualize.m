clear;
clf;

M = 5;
SWP = 30;
SWD = 90;
alpha = 0.05;
gamma = 0.15;
fileName = './s20501m.mat';

x = load(fileName).val(2,10000:15000);

% =====================================
% 2.1. Linear High-Pass Filteri
% =====================================

% M-point moving average filter
y1 = filter(1/M*ones(1,M), 1, x);

% Delay for (M+1)/2
y2 = filter([zeros(1, (M-1)/2), 1], 1, x);

y3 = y2 - y1;

% =====================================
% 2.2. Nonlinear Low-Pass Filtering Stag
% =====================================
y4 = movsum(y3.^2, SWP);

% =====================================
% 2.3. Decision-Making Stage
% =====================================
[peaks, loc] = findpeaks(y4, 'MinPeakDistance', SWD);

treshold = filter([1-alpha, alpha*gamma], 1, peaks);

idx = loc(peaks > treshold);

figure(1);

subplot(3,1,1);
hold on;
plot(x);
plot(loc(peaks > treshold), x(loc(peaks > treshold)), 'r*');
grid;
hold off;
title('Original signal & detections');
xlim([0 5000]);
set(gca,'xticklabel',[]);

subplot(3,1,2);
plot(y3);
grid;
title('After Linear High-Pass Filter Stage');
xlim([0 5000]);
set(gca,'xticklabel',[]);

subplot(3,1,3);
plot(y4);
grid;
title('After Nonlinear Low-Pass Filter Stag');
xlim([0 5000]);