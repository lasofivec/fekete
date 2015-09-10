function values = bxval(xi,xx)
%
% values = bxval(xi, xx)
%
% returns the values of the box spline with directions xi at the
% points xx(:,j), j=1,2,...
% C de Boor: 23 jun 92

% STARS = ' ********** in bxval ***************** '
% size(xi)
%xi
%xx



[dx,ignored] = size(xi); [d,ignored] = size(xx);
if (dx ~= d),
    error('directions and points are of different dimensions.'), end
perturb = max(max(abs(xi)))*1.e-10; % <<< note use of tolerance

'(((((((((((((((((((((((((((((((((((((((((((('
[values, undef] = bxrec(xi,xx);
'))))))))))))))))))))))))))))))))))))))))))))'

while ~isempty(undef), % perturb any point on the mesh, then retry
    '~~~~~~~~~~~~~~~ in while loop ~~~~~~~~~~~~~~~ '
    [vu, uu] = ...
        bxrec(xi,xx(:,undef)+(rand(d,1)*perturb)*ones(1,length(undef)));
    values(undef) = vu;
    undef = undef(uu);
end

% STARS = ' ********** end bxval ***************** '