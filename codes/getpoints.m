function [p1,p2,p3,p4] = getpoints(clearedIm)
p1 = [0 0]';
p2 = [0 0]';
p3 = [0 0]';
p4 = [0 0]';
[xlen,ylen] = size(clearedIm);
xymin = xlen + ylen;
xymax = 0;
yxmin = ylen;
yxmax = -xlen;
for i = 1:1:xlen
    for j = 1:1:ylen
        if clearedIm(i,j) == 1
            if i+j < xymin
                p1 = [i,j]';
                xymin = i + j;
            end
            if i+j > xymax
                p4 = [i,j]';
                xymax = i + j;
            end
            if j - i < yxmin
                p2 = [i,j]';
                yxmin = j - i;
            end
            if j - i > yxmax
                p3 = [i,j]';
                yxmax = j - i;
            end
        end
    end
end
                
                