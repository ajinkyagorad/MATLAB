%am modulation (single tone)

clear
clc
dT = 1E-4;
t = -1:dT:1;
%% Generate carrier and message
fm = 10
fc = 1000
k  = 2
mt = sin(2*pi*fm*t);
ct = sin(2*pi*fc*t);
A = 1;
%% Generate modulated signal
st = A*(1+k*mt).*ct;

%% Demod using rectifier and low pass
srx = st.*sign(st);
f_cutoff = 50
n = 500;        % size of rect FIR filter
x = (-n:n)*dT;
LPF= sinc(f_cutoff*x);
% apply transform
S_L = conv(srx,LPF);
S_L = S_L(n+1:n+length(srx));
%% Plot
plot(t,srx);
hold on
plot(t,S_L);



