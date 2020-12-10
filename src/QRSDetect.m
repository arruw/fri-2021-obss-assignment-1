function [idx] = QRSDetect(fileName, M, SWP, SWD)
% fileName - path to the record *m.mat file
% M - even value 3, 5, 7, 9 (5 or 7 is recommended)
% SWP - processing sliding window size (recommended 30 for 200 Hz)
% SWD - decision making sliding window size (?)

  x = load(fileName).val(1,:);
  
  % =====================================
  % 2.1. Linear High-Pass Filteri
  % =====================================
  
  % M-point moving average filter
  y1 = filter(1/M*ones(1,M), 1, x);
  
  % Delay for (M+1)/2
  % y2 = filter([zeros(1, (M-1)/2), [(M+1)/2]], 1, x);
  
  % y = y2 - y1;
  y = x - y1;
  
  % =====================================
  % 2.2. Nonlinear Low-Pass Filtering Stag
  % =====================================
  % 200 Fs ...  30 window size
  % 250 Fs ... ~38 window size
  y = movsum(y.^2, SWP);
  
  % =====================================
  % 2.3. Decision-Making Stage
  % =====================================
  [peaks, loc] = findpeaks(y, 'MinPeakDistance', SWD);
  
  alpha = 0.05;
  gamma = 0.15;
  treshold = filter([1-alpha, alpha*gamma], 1, peaks);

  idx = loc(peaks > treshold);
end