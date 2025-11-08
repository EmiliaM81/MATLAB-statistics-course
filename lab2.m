clear; clc;
n=100;
a=1103515245;
b=12345;
m=2^31;

x=1;

for i=2:n
    x(i)=mod(a*x(i-1)+b, m);
end

histogram(x,32)