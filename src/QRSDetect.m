function [idx] = QRSDetect(fileName, M, SWP, SWD, alpha, gamma)
% fileName - path to the record *m.mat file
% M - even value 3, 5, 7, 9 (5 or 7 is recommended)
% SWP - processing sliding window size (recommended 30 for 200 Hz Fs)
% SWD - decision making sliding window size
% alpha - forgetting factor (recommended 0.05)
% gamma - weighting factor (recommended 0.15)

  x = load(fileName).val(1,:);
  
  % =====================================
  % 2.1. Linear High-Pass Filter Stage
  % =====================================
  
  % M-point moving average filter
  y1 = filter(1/M*ones(1,M), 1, x);
  
  % Delay for (M+1)/2
  y2 = filter([zeros(1, (M-1)/2), 1], 1, x);
  
  y = y2 - y1;
  
  % =====================================
  % 2.2. Nonlinear Low-Pass Filter Stag
  % =====================================
  y = movsum(y.^2, SWP);
  
  % =====================================
  % 2.3. Decision-Making Stage
  % =====================================
  [peaks, loc] = findpeaks(y, 'MinPeakDistance', SWD);
  
  treshold = filter([alpha*gamma], [1, alpha-1], peaks);

  idx = loc(peaks > treshold);
end