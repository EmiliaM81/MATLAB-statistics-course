clear; clc;


%klasyfikator Bayesa
%problem klasyfkacji

load fisheriris;

d1 = 1;
d2 = 2; %d2 = 4

gscatter(meas(:,d1),meas(:,d2),species); %wyk1

cls = findgroups(species); % biezrze liczbe i sprawdza czy jest unikalna

gscatter(meas(:,d1),meas(:,d2),cls); %wyk2

n= length(cls);

k = .8;
nu = round(k*n);
nt = n - nu;



%ktore wartosci znamy a ktore nie znamy

%losujemy indeksy

idxu= randperm(n,nu);

% szukamy pozostałe indeksy - wartości kore nie zostały wylosowane

idxt = setdiff((1:n), idxu); %odejmujemy zbiory

gscatter(meas(idxu, d1), meas(idxu, d2), cls(idxu)); %wyk3 ??? byl nie dla idxt tylko idxu

hold on; % zachowuje wykres

plot(meas(idxt, d1), meas(idxt, d2), 'xk'); %wyk4

hold off;

for i = 1: 3;
    m(i,:) = mean( meas( idxu( cls( idxu )==i),: ) );
    s(i,:) = mean( meas( idxu( cls( idxu )==i),: ) );
    Pc(i) = sum (cls (idxu) == i)/nu;   %wyk5
end

%szykamy gdzie jest najwiekszcze P(c) * FNi(x)

for i = 1:3
    test(:, i) = Pc(i)*mvnpdf( meas( idxt, :), m(i, :), s(i, :));
end

[~, idx] = max( test, [], 2);


%gscatter( meas(idxt, d1), meas(idxt, d2), idx); %wyk6

gscatter( [ meas( idxt, d1); meas(idxu, d1) ], [ meas(idxt, d2); meas(idxu, d2) ],...
    [ idx * 10; cls(idxu)]); %wyk7


err = sum( idx ~= cls(idxt))/nt;

%szukamy punktow ktore sa zle sklasyfikowane

hold on;

plot( meas( idxt( idx ~= cls (idxt)), d1),...
meas( idxt (idx ~= cls(idxt)), d2), 'ko', ...
'MarkerSize', 8); %wyk8

hold off;