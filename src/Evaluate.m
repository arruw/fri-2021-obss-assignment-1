clear;
clf;

records = dir('../data/physionet.org/files/mitdb/1.0.0/*m.mat');

for i = 1:size(records, 1)
    record = records(i);
    recordPath = fullfile(record.folder, record.name);
    recordPath = recordPath(1:end-5);
    
    Detector(recordPath);
end