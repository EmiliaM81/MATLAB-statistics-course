%estymacja nieparametryczna
%na przykładzie estymacji gęstości rozkładu
% -2N(mi1, sigma1) .8(mi2, sigma2)

clear;clc;

n = 1e4;
k = .2;
n1 = k * n;
n2 = (1-k) * n;
m1 = -1;
s1 = 1;
m2 = 3;
s2 = 2;

z = [randn(1, n1) * s1 + m1, ...
    randn(1, n2) * s2 + m2];
hist = histogram(z); %wykres1

%jak szukac srodkow majac bin edges i bin width?

x = hist.BinEdges(1:end-1) + hist.BinWidth/2; %otrzymamy osie x odpowiadajace polozeniu histogramu

f = pdf('Normal',x,m1,s1)*n1/n + ...
    pdf('Normal',x,m2,s2)*n2/n;

%plot(x,f); %wykres2 - ten wykres przypomina histogram,ale pole pod krzywa wynosi 1 a pole histgramu wynosi ..

fh = hist.Values/(n * hist.BinWidth);

plot(x, f, x, fh); %wykres3

%chcemy zmierzyc jak dobrze sie pokrywa, w tym celu obliczamy bład
%kwadratowy

errh = mean( (f-fh).^2);

%chcemy tak estymowac zeby doestac ciągłość funkcji

%estymator jądrowy 

%srodek jadra zawsze tam gdzie jest z
% h - parametr wygładzenia

h = 1.06 * std(z) *n^-.2; %h=1;

%ogólna postac estymatora (jest w notatkach)

for j = 1: length(x)
    ef(j)= sum( pdf ('Normal', (x(j) - z )/ h, 0, 1)) / (n * h);
end

plot(x,f,x,ef); %wykres6 czerwone - estymator, niebieskie - funkcja

%aby lepiej dopasowac biezemy mniejsze h

% parametr h da się dobrać w miare optymalnie (linijka 45 nowa wartość
% h~0.41), wykres 7 z nowym h

F = cdf('Normal',x,m1,s1)*n1/n + ...
    cdf('Normal',x,m2,s2)*n2/n; %dystrybuanta

plot(x,F); %wykres8

%jak zbudować estymator dystrybuanty

for i=1: length(x)
    eF(i) = sum( cdf ('Normal', (x(i)-z)/h, 0, 1))/n;
end

plot(x, F, x, eF); %wykres 9




%{
SPRAWOZDANIE
Generatory 





%}

