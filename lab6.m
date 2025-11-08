clear; clc;

%klasyfikator k-najblizszych sasiadow

load fisheriris;

cls = findgroups(species);

n = length(cls);

k = .5;

nidx = randperm(n, n*k);
tidx = setdiff(1:n, nidx);

udata = meas(nidx, :);
tdata = meas(tidx, :);

ucls = cls(nidx);
tcls = cls(tidx);

d1 = 2;
d2 = 4;
gscatter(udata(:, d1),... %rysujemy uczace punkty
    udata(:, d2), ucls); % wykres1


for i = 1: 3
    m(i,:) = mean( udata(ucls ==i, :) );
end

S = cov(udata);
% 
% for i = 1: 3 pierwszy sposob
%     distE(:, i) = sum((tdata - m(i,:) ).^2, 2 );
% end
% 
% %ktora klasa jest najbliżej
% 
% [~, clsE] = min(distE, [], 2);
% 
% gscatter( [udata(:, d1); tdata(:, d1)],...
%     [udata(:, d2); tdata(:, d2)], [ucls; 10*dsE]); %wykres2
% 
% %sprawdzamy  ile razy mieliśmy racje, wydajnosc
% 
% effE = mean(tcls== clsE); %ile poprawnie klasyfikujemy



%wersja z odlegloscia machalanobisa tego u gory

for i = 1: 3
    distE(:, i) = sum((tdata - m(i,:) ).^2, 2 );
    for j = 1: (n*k)
        distM(j, i) = (tdata(j,:) - m(i, :))*S^-1 *...
            (tdata(j,: ) - m(i, :))';
    end
end

[~, clsE] = min(distE, [], 2);
[~, clsM] = min(distM, [], 2);

gscatter( [udata(:, d1); tdata(:, d1)],...
    [udata(:, d2); tdata(:, d2)], [ucls; 10*clsE]); %wykres3

effE = mean(tcls== clsE);
effM = mean(tcls== clsM);

%dane sa standarywowane dlatego ujednolicamy wariacje dlatgo wynik jest
%gorszy mimo bardziej skomplikowanej metody

%teraz chcemmy policzyc wszystkie odległości jakie są 

%dla każdego punktu liczymy odległości - najbardziej skuteczny sposob

for i = 1:(n*k)
    distN(:,i) = sum( (tdata - udata(i, :)).^2, 2 );
end

K = 5; % 5 najblizszych sasiadow



for i = 1: n*(1-k)
    [~, idx] = sort( distN(i, :));
    l = ucls( idx( 1: K) );

    for j = 1: 3
        rnk(i, j) = sum ( l==j ); % dla i-tego pomiaru ile jest j-tych klas
    end
end


[~, idxN] = max(rnk, [], 2);

effN = mean( idxN == tcls);

%wychodzi lepiej

