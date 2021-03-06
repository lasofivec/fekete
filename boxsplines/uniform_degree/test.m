xb = -2.5 ; xe =3.5;
yb = -0.5 ; ye = 3.5;
n = 20;
x = linspace(xb,xe,n);
y = linspace(yb,ye,n);

[X,Y]=meshgrid(x,y);

XY = zeros(2, n*n);
XY(1, :) = reshape(X, [1, n*n]);
XY(2, :) = reshape(Y, [1, n*n]);

%f = boxSplineD2(X,Y);
%f = boxSplineLinear(X,Y);

mat = [1, 0, 1, -1; 0, 1, 1, 1];

f = bxval(mat, XY);

nonzeros(f)
surf(x,y,reshape(f,[n,n])); 
%shading interp;
%xlabel('x');
%ylabel('y');
%contourf(x,y,reshape(f, [n, n])); colorbar(); 

