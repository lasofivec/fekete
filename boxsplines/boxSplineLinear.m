%matlab code for the 2D box Spline

function val = boxSplineLinear(X,Y)

val = max(0, 1- max(abs(X)+1/sqrt(3)*abs(Y), abs(Y)));
