function t_samp = sync(mf, b_train, Q, t_start, t_end)
% t_samp = sync(mf, b_train, Q, t_start, t_end)
%
% Determines when to sample the matched filter outputs. The synchronization
% algorithm is based on cross-correlating a replica of the (known)
% transmitted training sequence with the output from the matched filter
% (before sampling). Different starting points in the matched filter output
% are tried and the shift yielding the largest value of the absolute value
% of the cross-correlation is chosen as the sampling instant for the first
% symbol.
%
% Input:
%   mf            = matched filter output, complex baseband, I+jQ
%   b_train       = the training sequence bits
%   Q             = number of samples per symbol
%   t_start       = start of search window
%   t_end         = end of search window
%
% Output:
%   t_samp = sampling instant for first symbol
    c = qpsk(b_train);
    L = length(c);
    possible_t_samp = [];
    for t = t_start:1:t_end
        a = 0;
        for k = 1:1:L
            a=a+mf(k*Q+t)*c(k);
        end
        possible_t_samp = [possible_t_samp a];
    end
    %corr = xcorr(mf(t_start:t_end),b_train_qpsk_replica);
    %stem(abs(possible_t_samp))
    [~,t_samp] = max(abs(possible_t_samp)); %Find the correct alignment of mf
    t_samp = t_samp + t_start -1;
end
