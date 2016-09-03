%%implement hilbert transform of wave 
clear
clc
dT = 1/10000;     % time steps
fs = 1/dT;
% Generate FIR (Finite Impulse Response) filter
n = 5000; %FIR parameter
h = 1:n;
h = 1./h/pi;
H = [ -fliplr(h) 0 h];   % Generate Filter
%% Generate Signal
%square wave
nCyc = 5;
f = 100
oversampling = fs/f
t = 1/fs:1/fs:nCyc/f;
maxtime = t(end)
x = ones(1,oversampling/2);
X = [];
for i=1:2*nCyc
    X= [X ((-1)^i) * x];
end

% %sine wave
% f = 100
% oversampling = fs/f
% nCyc = 5;      % cycles of sine wave
% t = 1/fs:1/fs:nCyc/f;
% phase = (pi/180)*30; % phase in degrees
% X = sin(2*pi*f*t+phase);
%%Find Transformation
Xh = conv(X,H); 
Xh = Xh(n+1:n+length(X));

%% now merge  both signals into one and modulate them
S = X+j*Xh;
fc = 40E3  %carrier frequency



