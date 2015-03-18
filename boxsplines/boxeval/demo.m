echo off
%%
%% (Leif Kobbelt - 07/11/96)
%%

clc, home

echo on

%% This is a script file to demonstrate the use of the box_eval() function
%% which allows the stable and efficient evaluation of box-splines.

%% A box-spline ist a piecewise polynomial function from \R^s to \R.
%% It is defined by a matrix of k mutually distinct (s-dim) column vectors.
%% The first example uses s = k = 2 ...

X  = [ 1  0 ;
       0  1 ];

X2  = [ 1  0 -1;
       0  1  1];
   
%% The multiple occurrence of identical column is logged in a vector nu
%% holding the number of times each direction is repeated.

nu = [2;2];
nu2 = [1;1];
nu3 = [2;2;1];

%% The box-spline evaluation can be applied to a whole set of sample
%% points. Here we construct a uniform grid over an approriate interval.

N1 = 65
N2 = 10
[xx,yy] = meshgrid(((1:N1)-2)/N2,((1:N1)-2)/N2);
 p      = [xx(:) yy(:)];

%% To also demonstrate the efficiency of the algorithm, we measure the
%% execution time.

tic
b = box_eval(X, nu2, p);
c = box_eval(X,nu,p-1.2);
d = box_eval(X2,nu3,p-3);
toc

bmat = reshape(b,N1,N1);
cmat = reshape(c,N1,N1);
dmat = reshape(d,N1,N1);
% surf(bmat); hold on
% surf(cmat); hold on
% surf(dmat);

bcol = bmat(:,6);
ccol = cmat(:,24);
dcol = dmat(:,40);
YMat = [bcol ccol dcol];
%createfigure(bmat,cmat,dmat,reshape(YMat,N1,3))


% Create multiple lines using matrix input to plot
plot1 = plot(reshape(YMat,N1,3));
set(plot1(1),'DisplayName','\Xi_{[e1, e2]}');
set(plot1(2),'DisplayName','\Xi_{[e1, e2, e1, e2]}');
set(plot1(3),'DisplayName','\Xi_{[e1, e2, e1, e2, -e1, e2]}');

ylim([-2.5905203908e-18 1.1]);

% %% The surface you see right now is the graph of a biquadratic tensor
% %% product Box-spline function.
% 
% pause  %% press any key to see more examples
% 
% clc, home
% 
% %% The next example has k = 4 distinct directions in \R^s = \R^2
% %% each occurring only once.
% 
%  X      = [ 1  0   1  1 ;
%             0  1  -1  1 ];
%  nu     = [1;1;1;1];
% [xx,yy] = meshgrid(((1:20)-2)/6,((1:20)-8)/6);
%  p      = [xx(:) yy(:)];
% 
% tic
% b = box_eval(X,nu,p);
% toc
% 
% surf(reshape(b,20,20))
% 
% %% The resulting function is called the Zwart-Powell-element
% 
% pause  %% press any key for one more example
% 
% clc, home
% 
% %% The last example uses k = 3 directions in \R^s = \R^2. Each has
% %% the multiplicity two.
% 
%  X      = [ 1  0  1 ;
%             0  1  1 ];
%  nu     = [2;2;2];
% [xx,yy] = meshgrid(((1:20)-2)/5,((1:20)-2)/5);
%  p      = [xx(:) yy(:)];
% 
% tic
% b = box_eval(X,nu,p);
% toc
% 
% surf(reshape(b,20,20))
% 
% %% This last function is obtained by repeating the directions defining
% %% the Courant-element twice.
% 
