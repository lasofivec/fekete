function [values,undef] = bxrec(xi,x)
%
% [values, undef] = bxrec(xi, x)
%
% recursive m-file for computing (however expensively) M_{xi}(x).
% Note that x(:,undef) have been found to lie `on' the mesh for
% M_{xi}, hence need to be perturbed by the calling program. For
% this reason, it is better to use bxval which calls on bxrec
% and perturbs the argument if need be until it gets it `off'
% the mesh.
% The action could be speeded up somewhat by recognizing
% multiplicities explicitly.
% C de Boor: 4 jul 92/ 12 aug 92

STARS = ' *************in bxrec ************** '
% size_xi = size(xi)
% size_x = size(x)
%xi
%x

[s,n] = size(xi); [ignored,nx] = size(x);
values = zeros(1,nx); undef = [];
% zero values will be returned unless xi is of full rank.
% Compute the QR factorization for xi as a means of telling
% whether or not xi is of full rank. Since the factorization is
% needed for this, it also comes in handy for determining a
% reasonable solution of xi? = x .
[q,r,e] = qr(xi); ad = abs(diag(r));

% q is unitary, r is upper triangular,
% with absol. decreasing diagonal elements,
% and e is a permutation matrix.
if ad(1) < (1.e+10)*ad(s),% If xi is of full rank,
    t = (r*e')\(q'*x);% compute t as the smallest solution of xi?=x.
    
    % Further,
    if (s==n), % if xi is square, return the characteristic function
        % of xi(\boxx) , divided by abs(det(xi)) , retaining in
        % undef those j for which x(:,j) is on the mesh.
        ' ===> is squared '
        undef = find(min([abs(t);abs(1-t)])<1.e-12);
        ok = 1:nx; ok(undef)=[];
        values(ok) = (0<=min(t(:,ok))&max(t(:,ok))<1)/prod(ad);
%         t
%         ok
%         max(t(:,ok))
%         maxi = max(t(:,ok))<1
%         max(t)
%         max(t) < 1
%         values
%         undef
%         ' +++++++++++++++squared end++++++++++++++++++++ '
    else, % use the recurrence relations, but only for the x(:,j)
        % in the smallest axiparallel cube containing supp M_{xi}, ...
        ' ===> is NOT squared '
        g = find(max(x-sum(max(xi',zeros(n,s)))'*ones(1,nx))<=0& ...
            min(x-sum(min(xi',zeros(n,s)))'*ones(1,nx))>=0);
        lg = length(g);
        j=1; xicut = xi(:,2:n); % xicut contains all directions but the
        % one currently left out.
        
        while lg>0, % compute and add the jth term of the recurrence:
             ' ------------ IN WHILE ---------------'
            [vj, uj] = bxrec(xicut,[x(:,g),x(:,g)-xi(:,j)*ones(1,lg)]);
            
	    return

            values(g) = ...
                values(g) + t(j,g).*vj(1:lg) + (1-t(j,g)).*vj(lg+[1:lg]);
            
%             ' +++++++++++++++++++++++++++++++++++ '
%             xicut
%             [x(:,g),x(:,g)-xi(:,j)*ones(1,lg)]
%             vj
%             uj
%             ' +++++++++++++++++++++++++++++++++++ '
            
            if ~isempty(uj), % remove undefineds from further consideration
%                 ' #### uj is not empy '
%                 g
                indic = zeros(1,lg);
                [1:lg,1:lg];
                indic(ans(uj)) = ones(1,length(uj));
                uj = find(indic==1);
                undef = [undef, g(uj)];
                g(uj) = [];
                lg = length(g);
%                 ' +++++++++++++++++++++++++++++++++++ '
%                 indic
%                 uj
%                 undef
%                 g
%                 lg
            end
            if (j == n), 
                'ooooooooooo * break loop * oooooooooooooo'
                break, end
            xicut(:,j) = xi(:,j); % increment j and update xicut .
            j = j+1;
        end
        values = values/(n-s);
    end
end
