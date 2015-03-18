function val = boxSplineDn(x,y, n)
x = -abs(x);
y = abs(y);

u = x-y/sqrt(3);
v = x+y/sqrt(3);
id = find(v>0);     v(id) = -v(id); u(id)=u(id)+v(id);

id = find(v > u/2); v(id) = u(id)-v(id);
val = zeros(size(x));

for K=-n:(ceil(max(max(u)))-1)
for L = -n:(ceil(max(max(v)))-1)
for i=0:min(n+K,n+L)
coeff = (-1)^(K+L+i)*nchoosek(n,i-K)*nchoosek(n,i-L)*nchoosek(n,i);
for d=0:n-1
aux = abs(v-L-u+K);
aux2= (u-K+v-L-aux)/2;
aux2(find(aux2<0))=0;
val =val + coeff*nchoosek(n-1+d,d)/ ...
factorial(2*n-1+d)/factorial(n-1-d)* ...
aux.^(n-1-d).*aux2.^(2*n-1+d);
end
end
end
end
ind = find(u > 1);

b(ind) = ((v(ind)-2).^3).*(g(ind)-1)/6;
ind = find(v>2);
b(ind) = 0;      %outside support

%b = b/(sum(sum(b)));
