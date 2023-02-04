function bhat = detect(r)
% bhat = detect(r)
%
% Computes the received bits given a received sequence of (phase-corrected)
% QPSK symbols. Gray coding of the individual bits is assumed. Hence, the
% two bits for each symbol can be detected from the real and imaginary
% parts, respectively. The first of the two bits below is output first in
% the bhat-sequence.
%
% Assumed mapping:
%
%  10 x   |   x 00
%         |
%  -------+-------
%         |
%  11 x   |   x 01
%
% Input:
%   r  = sequence of complex-valued QPSK symbols
%
% Output:
%   bhat  = bits {0,1} corresponding to the QPSK symbols
even_idx = zeros(1,length(r));
odd_idx = zeros(1,length(r));
I = real(r);
Q = imag(r);
for i = 1:1:length(I)
    if I(i) > 0
        even_idx(i) = 0;
    else
        even_idx(i) = 1;
    end
    if Q(i) > 0
        odd_idx(i) = 0;
    else
        odd_idx(i) = 1;
    end
end
bhat = zeros(1,2*length(r));
bhat(1:2:end) = even_idx;
bhat(2:2:end) = odd_idx;

