# QRS Detection

Implementation is based on paper *A moving average based filtering system with its application to real-time QRS detection* [1].

Report: [here](./report.pdf)

## Requirements
* [WFDB Software Package](https://archive.physionet.org/physiotools/wfdb.shtml)

## Tools

**Download MIT-BIH database [2]**
```bash
$ cd data
$ wget -r -N -c -np https://physionet.org/files/mitdb/1.0.0/
```

**Convert database to MATLAB format**
```bash
$ ./convert2mat.sh
```

**Convert MATLAB detections to qrs format**
```bash
$ ./convert2qrs.sh
```

**Evaluate results**
```bash
$ ./evaluate.sh
```

## Literature

[1] [Chen, H. C., and Szi-Wen Chen. "A moving average based filtering system with its application to real-time QRS detection." Computers in Cardiology, 2003. IEEE, 2003.](http://cinc.org/archives/2003/pdf/585.pdf)

[2] [Moody, George B., and Roger G. Mark. "The MIT-BIH arrhythmia database on CD-ROM and software for use with it." [1990] Proceedings Computers in Cardiology. IEEE, 1990.](http://georgebmoody.com/publications/mitdb-cinc-1990.pdf)

