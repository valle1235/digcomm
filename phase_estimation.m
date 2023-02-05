function phihat = phase_estimation(r, b_train)
% phihat = phase_estimation(r, b_train)
%
% Phase estimator using the training sequence. The phase estimate is
% obtained by minimizing the norm of the difference between the known
% transmitted QPSK-modulated training sequence and the received training
% part. NB! There are other ways of estimating the phase, this is just
% one example.
%
% Input:
%   r       = received baseband signal
%   b_train = the training sequence bits
%
% Output:
%   phihat     = estimated phase
b_train_qpsk = qpsk(b_train);
corr = xcorr(r,b_train_qpsk);
[~, alignment] = max(abs(corr)); %Finds max value of the correlation -> finds the shift where r and b_train best align i.e. minimizing the norm
phihat = angle(corr(alignment));
