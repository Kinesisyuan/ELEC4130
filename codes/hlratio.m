function [ratio,numdot,thlsize] = hlratio(index, labelled)
    numdot = 0;
    [xlen,ylen] = size(labelled);
    xmin = xlen;
    xmax = 1;
    ymin = ylen;
    ymax = 1;
    for i = 1:1:xlen
        for j = 1:1:ylen
            if labelled(i,j) == index
                numdot = numdot + 1;
                if i > xmax
                    xmax = i;
                end
                if i < xmin
                    xmin = i;
                end
                if j > ymax
                    ymax = j;
                end
                if j < ymin
                    ymin = j;
                end
            end
        end
    end
    ratio = (ymax - ymin)/(xmax - xmin);
    thlsize = (ymax - ymin)*(xmax - xmin);
end

