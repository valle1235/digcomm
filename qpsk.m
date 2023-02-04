function d = qpsk(b)
% d = qpsk(b)
%
% Map the bits to be transmitted into QPSK symbols using Gray coding. The
% resulting QPSK symbol is complex-valued, where one of the two bits in each
% QPSK symbol affects the real part (I channel) of the symbol and the other
% bit the imaginary part (Q channel). Each part is subsequently PAM
% modulated to form the complex-valued QPSK symbol. The energy per QPSK
% symbol is normalized to unity.
%
% The mapping resulting from the two PAM branches are:
%
% complex part (Q channel)
%         ^
%         |
%  10 x   |   x 00   (odd bit, even bit)
%         |
%  -------+------->  real part (I channel)
%         |
%  11 x   |   x 01
%         |
%
%
%
% Input:
%   b = bits {0, 1} to be mapped into QPSK symbols
%
% Output:
%   d = complex-valued QPSK symbols

%If the first bit of the symbol is 0 -> real part is positive
%If second bit of the symbol is 0 -> imaginary part is positive
%This achieves gray coding

    b_nrz = 2*b -1; %{0,1} -> {-1,1}, NRZ encoding
    I=b_nrz(1:2:end); %Odd indexes
    Q=b_nrz(2:2:end); %Even indexes
    t=1:1/(length(I)):1;
    I_channel = I.*cos(2*pi*(1/4)*t +pi/4);
    Q_channel = Q.*sin(2*pi*(1/4)*t +pi/4);
    d = I_channel - 1i*Q_channel;
end
