function b = boxSplineD2(x,y)

u = abs(x)-abs(y)/sqrt(3);
v = abs(x)+abs(y)/sqrt(3);
b = zeros(size(x));

ind = find(u <0);
u(ind) = -u(ind);
v(ind) = v(ind)+ u(ind);

ind = find(2*u <v);
u(ind) = v(ind)- u(ind);

g = u - v/2;

b = 5/6 + ((1+(1/3 - v/8).*v).*v/4-1).*v + ... 
((1-v./4).*v+g.*g./6-1).*g.*g;


ind = find(v < 1);
vi = v(ind);
gi = g(ind);
b(ind) = 0.5 + ((5/3-vi/8).*vi-3).*vi.*vi/4+((1-vi/4).*vi+gi.*gi/6.0-1).*gi.*gi;
clear vi gi;
