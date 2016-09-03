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
%% Square wave
% nCyc = 20;
% f = 100       ; frequency of square wave
% oversampling = fs/f
% t = 1/fs:1/fs:nCyc/f;
% maxtime = t(end)
% x = ones(1,oversampling/2);
% X = [];
% for i=1:2*nCyc
%     X= [X ((-1)^i) * x];
% end

%% Custom Digital Data
dataRate = 100
data = [1 0 1 1 0 0 1 0 1 0 1 1 1 0 0 0 1 0 1 0 1 0]
data = 2*data-1; %
bits = length(data);
oversampling = fs/dataRate
t = 1/fs:1/fs:bits/dataRate;
maxtime = t(end)
x = ones(1,oversampling);
X = [];
for k=1:bits
    X= [X data(k)* x];
end

%% Sine wave
% f = 1000
% oversampling = fs/f
% nCyc = 10;      % cycles of sine wave
% t = 1/fs:1/fs:nCyc/f;
% phase = (pi/180)*30; % phase in degrees
% X_sin = sin(2*pi*f*t+phase);


%% Find Hilbert Transformation
Xh = conv(X,H); 
Xh = Xh(n+1:n+length(X));

%% now merge  both signals into one and modulate them
S = X+j*Xh;
%resample the signal
S = resample(S,10,1);
t = resample(t,10,1);           dT = dT/10; %adjust to timing parameter of sampling

fc = 30E3  %carrier frequency
phase_c = (pi/180)*0 %carrier phase
St = S.*exp(j*(2*pi*fc*t+phase_c));
st = real(St);   % signal to be transmitted
plot(t,real(st))
hold on
plot(t,imag(st))
pause(1)
%% Now simulate channel
% upsample and add noise
S_channel = resample(st,10,1);
t = resample(t,10,1);   % maintain consistensy with time
SNR = 10
S_channel = awgn(S_channel,SNR);
%% Reception of signal
Srx = resample(S_channel,1,10);
t = resample(t,1,10);
Srx = Srx(1:end-100);   % drop last samples as resampling messes with it
t = t(1:end-100);
%get cos component of wave , mix it with cos at fc
frx_offset = 0     % frequency offset in receiver
Srx_Mixed = Srx.*cos(2*pi*(fc+frx_offset)*t);
plot(t,Srx_Mixed)
%% Low pass filter the signal
%generate  filter
f_cutoff = 1000  ; % cutoff frequency of filter
n = 5000;        % size of rect FIR filter
x = (-n:n)*dT;
LPF= sinc(f_cutoff*x);
% apply transform
S_L = conv(Srx_Mixed,LPF);
S_L = S_L(n+1:n+length(Srx_Mixed));
pause(1)
hold on
plot(t,S_L)
hold off
pause(2)
%% Now digital Data from the output signal
D = 0.5*(sign(S_L)+1);
x = 1:length(D);
D = D.*sin(x);
plot(t,D);















