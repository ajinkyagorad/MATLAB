%%implement hilbert transform of wave 
clear
clc
% define filter
n = 100; %length of filter
h = [1:n];
h = 1./h/pi;
H = [ -fliplr(h) 0 h];   % Generate Filter
%% Generate Signal
% %square wave
% x = ones(1,50);
% X = [];
% for i=1:20
%     X= [X ((-1)^i) * x];
% end

%sine wave
x = [1:1000];
X = sin(0.1*x);

Xh = conv(X,H);
Xh = Xh(n+1:n+length(X));
%% now merge  both signals into one and modulate them
S = X+j*Xh;

