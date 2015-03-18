xb = -1.5 ; xe = 1.5; 
yb = -1.5 ; ye = 1.5;
n = 41;
x = linspace(xb,xe,n);
y = linspace(yb,ye,n);
[X,Y]=meshgrid(x,y);

f  = boxSplineLinear(X,Y);
fl = f((n-1)/2, :);
f2 = boxSplineD2(X,Y);
fl2 = f2((n-1)/2, :);
surf(x,y,f); 
%surf(x,y,f2); shading interp
alpha(.6)
%colormap(gray);
% contourf(x,y,f);
colorbar(); 

