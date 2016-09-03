%%implement hilbert tranfsorm of wave 
% define filter
n = 100; %length of filter
h = [1:n];
h = 1./h;
H = [ -fliplr(h) 0 h]   % Generate Filter
% Generate Signal
x = ones(1,50);
X = [];
for i=1:20
    X= [X ((-1)^i) * x]
end

Xh = conv(X,H);
Xh = Xh(n+1:n+length(X));
plot(X)
hold on
plot(Xh)


