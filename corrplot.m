function h = corrplot(x, vx)

    nvar = size(x,2);
    if nvar == 1
        disp('X must have at least two variables (columns) for the correlation to make sense')
        return
    end
    if nargin == 1
        for jj = 1:nvar
            varlbl{jj} = num2str(jj);
        end
        vx = 'f';
    elseif nargin == 2
        for jj = 1:nvar
            lbl{jj} = [varlbl{1},'&',varlbl{jj}];
        end
        vx = 'f';
    elseif nargin == 3
        if isempty(varlbl)
            for jj = 1:nvar
                varlbl{jj} = num2str(jj);
            end
        end
    end
    [r,~,rlo,rup] = corrcoef(x,'rows','complete');
    rlo = rlo -r;
    rup = rup -r;
    switch lower(vx)
        case 'f'
            N = 1;
        case 'a'
            N = nvar-1;
    end
    Y = []; L = []; U = [];
    m = 1;
    for jj = 1:N
        Y = [Y, r(jj,jj+1:nvar)];
        L = [L, rlo(jj,jj+1:nvar)];
        U = [U, rup(jj,jj+1:nvar)];    
        for kk = jj+1:nvar
            lbl{m} = [varlbl{jj},'&',varlbl{kk}];
            m = m+1;
        end
        X = 1:length(Y);
    end
    hh = errorbar(X,Y,L,U,'s');
    set(gca, 'xtick', X, 'xticklabel',lbl)
    if nargout == 1
        h = hh;
    end

end

