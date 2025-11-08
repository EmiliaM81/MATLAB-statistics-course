%estymator jądrowy

clear; clc;

z = [-1, 1, 2];
h=1;

x = -4:.1:5;

K = @(w)(pdf('Normal',w,0,1));

%wykres jednego jądra
%plot (x, K((x-z(1))/h)); %wykres4

%trzy jądra 
% zamiast poszczegole slupki histogramu mamy cały przebieg
plot (x, K((x-z(1))/h), x, K((x-z(2))/h),x, K((x-z(3))/h),...
    x, K((x-z(1))/h)+ K((x-z(2))/h)+K((x-z(3))/h)); %wykres5


%gdy zwieksza sie h  wykres wygładza się i pole się zwiększa
%gdy zmniejsza się h wykres jest bardziej zwarty
% przy ekstremalnie małych h np. 0.01 wracamy do histogramu


