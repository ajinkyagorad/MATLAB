%am modulation (single tone)
clear
clc
dT = 1E-4;
t = -1:dT:1;
fm = 100
fc = 1000
k  = 0.5
mt = sin(2*pi*fm*t);
ct = sin(2*pi*fc*t);
A = 1;
st = A*(1+k*mt)*ct;

