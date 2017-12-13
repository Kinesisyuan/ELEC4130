function transformation(originIm,p1,p2,p3,p4)
% figure(1000);
% imshow(originIm);

%movement
t = p1;
%vectors after transformation
a = p2 - p1;
b = p3 - p1;
c = p4 - p1;
%size of plate is 140*440, take image 280*880
x = [280 0]';
y = [0 880]';
w = [280 880]';
%calculate transformation matrix for x,y
Q = [a b];
S = [x y];
R = Q * inv(S);
%caculate transformation matrix for w
r1 = c(1)/280;
r2 = c(2)/880;
Rwc = [r1 0;
       0  r2];
%Rwc * w = c
plate = zeros(280,880,3);
for i = 1:1:280
    for j = 1:1:880
        if j/i > 880/280
            oriw = i/280 * w;
            oriy = [0; (j - i * 880/280)];
            pos_in_ori = R * oriy + Rwc * oriw + t;
        end
        if j/i <= 880/280
            oriw = j/880 * w;
            orix = [(i - j * 280/880);0];
            pos_in_ori = R * orix + Rwc * oriw + t;
        end
        for k = 1:1:3
        plate(i,j,k) = originIm(uint16(pos_in_ori(1)),uint16(pos_in_ori(2)),k);
        end
    end
end
% figure(1001);
% imshow(uint8(plate));


imshow(uint8(plate));
imwrite(uint8(plate),'result.jpg');
