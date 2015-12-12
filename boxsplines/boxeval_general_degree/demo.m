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

X  = [ sqrt(3)*0.5 -sqrt(3)*0.5  ;
       0.5 0.5];

X2  = [ sqrt(3)*0.5 -sqrt(3)*0.5  0;
       0.5 0.5 1];
   %% The multiple occurrence of identical column is logged in a vector nu
%% holding the number of times each direction is repeated.

nu2 = [2;2;2];
nu11 = [1;1];
nu12 = [1;1;1];
nu3 = [3;3];
%% The box-spline evaluation can be applied to a whole set of sample
%% points. Here we construct a uniform grid over an approriate interval.

N1 = 60;
N2 = 10;
L1 = 4;%sqrt(3.0)
L2 = 4;%1.
%[xx,yy] = meshgrid(((1:N1)-sqrt(3)*0.5)/N2,((1:N1)-sqrt(3)*0.5)/N2);
[xx,yy] = meshgrid( (1:N1)/N1*L1-1.5, (1:N1)/N1*L2-0.3 );
 p      = [xx(:) yy(:)];

%% To also demonstrate the efficiency of the algorithm, we measure the
%% execution time.

tic
'computing b................'
b = box_eval(X, nu11, p);
'computing c................'
c = box_eval(X2,nu12,p);
'computing d................'
d = box_eval(X2,nu2,p);
toc
maxval = max(b(:,:));
bmat = reshape(b,N1,N1);
cmat = reshape(c,N1,N1);
dmat = reshape(d,N1,N1);


% surf(xx, yy, bmat); hold on
% surf(xx+1, yy+1, cmat); hold on
% surf(xx+2, yy+2, dmat);
% xlabel('x','Fontsize',14);
% ylabel('y','Fontsize',14);
% axis equal tight;
% shading interp; lighting phong;
% colorbar
% colorbar('Position',...
%      [0.903504043126687 0.180584551148225 0.0188679245283009 0.548794206101591]);
% set(gcf, 'Color', [1,1,1]);
% view([26,24]);
%myaa('publish');

% dmat
bcol = bmat(12,:);
ccol = cmat(20,:);
dcol = dmat(35,:);
x = xx(1,:);
y1 = bcol;
y2 = ccol;
y3 = dcol;
plot(x,y1,x+1,y2,'-o',x+2,y3,'-*')
legend('\Xi_{[r1, r2]}', '\Xi_{[r1, r2, r3]}', '\Xi_{[2r1, 2r2, 2r3]}')
ylim([0 1.2])
xlim([-1.5 4.5])
set(gcf, 'Color', [1,1,1]);
myaa('publish');

% 
%% The surface you see right now is the graph of a biquadratic tensor
%% product Box-spline function.

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
