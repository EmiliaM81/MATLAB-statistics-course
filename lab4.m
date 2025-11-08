clear; clc;

%jezeli lezy - nc nam  nie mówi
% jezeli nie lezy - balonik spadł

%test kołomogorova-smidrowa

n = 1e3;
m = 4;
s = 7;

x = icdf('Normal', rand(1, n), m, s);

x = sort(x);

histogram(x);

%sprawdzamy czy rozkład jest normalny
%test kołomogorowa

%statystyka kołomogorowa

%wyznaczamy dystrybuante empiryczną
Fe = @(z)(sum(x<z)/n);

F = cdf('Normal',x,m,s); %dajemy te parametry ktore chcemy przetestowac, hiopteza testowana  x ~ N(4,7)

for i = 1: n
    Fex(i) = Fe(x(i));
end

plot(x, F, x, Fex) %test kolomogorowa - szukamy gdzie jest największa różnica pomiędzy krzywymi 

D = max(abs(F - Fex));

K05 = 1.36;

D*n^0.5 < K05; % nasz test - sprawdzamy czy wychodzi więcej czy mniej - raz na 20 razy wychodzi 0
% to ze wychodzi 0 jest podstawą do odrzucenia hipoezy, 1 nic nam nie mówi

K = [1.07, 1.14, 1.22, 1.36, 1.63]; %kwantyle

N = 1000; % 1000 niezależnych testów;

res = zeros(1,5);

%rozkład normalny
for i = 1: N
    x = icdf('Normal', rand(1, n), m, s);
    x = sort(x);
    Fe = @(z)(sum(x<z)/n);
    F = cdf('Normal',x,m,s);
   
    Fex = zeros(1, n);
    for j= 1:n
        Fex(j) = Fe(x(j));
    end
    D = max(abs(F - Fex));
    res = res + ( D*n^.5 < K);
end

res = res/N;

%rozkład T
for i = 1: N
    x = icdf('T', rand(1, n), 10);
    x = sort(x);
    Fe = @(z)(sum(x<z)/n);
    F = cdf('Normal',x,0,1);
   
    Fex = zeros(1, n);
    for j= 1:n
        Fex(j) = Fe(x(j));
    end
    D = max(abs(F - Fex));
    res = res + ( D*n^.5 < K);
end

res = res/N;
