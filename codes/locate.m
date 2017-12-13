clear all;
close all;
originIm = imread('sample (40).jpg');
figure(1);
imshow(originIm);
hsvIm = rgb2hsv(originIm);
% figure(100);
% imshow(hsvIm);
[xlen,ylen,zlen] = size(originIm);
binImage = zeros(xlen,ylen);
for x = 1:1:xlen
    for y = 1:1:ylen
        if hsvIm(x,y,1)>= 0.5278 && hsvIm(x,y,1)<= 0.6805 ...
        && hsvIm(x,y,2)>= 0.3 && hsvIm(x,y,1)<= 1 ...
        && hsvIm(x,y,3)>= 0.275 && hsvIm(x,y,3)<= 1
            binImage(x,y) = 1;
        end
    end
end
% figure(2);
% imshow(binImage);

rmNoise = bwareaopen(binImage,20);
% figure(3);
% imshow(rmNoise)
seClose = ones(6,6);
se = ones(4,4);

closed = imclose(rmNoise,seClose);
closed = bwareaopen(closed, 60);

dilated = imdilate(closed,se);
dilated = bwareaopen(dilated, 100);

% figure(4)
% imshow(dilated);

labels = bwlabel(dilated);

stdratio = 440/140;

areas = max(max(labels));
ratio = [];
actsizes = [];
thlsizes = [];
for k =1:1:areas
    [theratio, actsize, thlsize] = hlratio(k, labels);
    ratio = [ratio, theratio];
    actsizes = [actsizes, actsize];
    thlsizes = [thlsizes, thlsize];
    if actsize/thlsize < 0.7
        for i = 1:1:xlen
            for j = 1:1:ylen
                if labels(i,j) == k
                  dilated(i,j) = 0;
                end
            end
        end
    end       
end

labels = bwlabel(dilated);
areas = max(max(labels));
actsizesnew = [];
for k =1:1:areas
    [theratio, actsize, thlsize] = hlratio(k, labels);
    actsizesnew = [actsizesnew, actsize];
end


maxsize = max(actsizesnew);
if isempty(actsizes)
    maxsize = 1;
end

dilated2 = bwareaopen(dilated, floor(0.6 * maxsize));

% figure(5)
% imshow(dilated2);

dilated2 = bwareaopen(dilated2, 100);
%%%%%%%%%%%%%%%%%%%%%%
clearlabel = bwlabel(dilated2);
areas = max(max(clearlabel));
clearratio = [];
for k =1:1:areas
    [theratio, actsize, thlsize] = hlratio(k, clearlabel);
    clearratio = [clearratio, theratio];
end

abs(clearratio - stdratio)

[minratiodiff, minpos] = min(abs(clearratio - stdratio));

cleared = zeros(xlen, ylen);
for i = 1:1:xlen
    for j = 1:1:ylen
        if clearlabel(i,j) == minpos
            cleared(i,j) = 1;
        end
    end
end

cleared = imclose(cleared, ones(10,10));

% figure(6);
% imshow(cleared);

[p1,p2,p3,p4] = getpoints(cleared);

transformation(originIm,p1,p2,p3,p4);