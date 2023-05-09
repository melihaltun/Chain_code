% @fileName testChainCode.m
% @author Melih Altun @2023

clear; clc; close all;

img = [0 0 0 0 0 0 0 0 0 0 0
       0 0 1 1 1 1 1 1 1 0 0
       0 1 1 1 1 1 1 1 1 1 0
       0 1 1 1 1 1 1 1 1 0 0
       0 1 1 1 0 0 0 0 0 0 0
       0 1 1 1 1 1 1 1 0 0 0
       0 1 1 1 1 1 1 1 1 0 0
       0 0 1 1 1 1 1 1 1 1 0 
       0 0 0 0 0 0 0 1 1 1 0
       0 0 0 0 0 0 0 1 1 1 0
       0 0 1 1 1 1 1 1 1 1 0
       0 1 1 1 1 1 1 1 1 0 0
       0 0 1 1 1 1 1 1 0 0 0];


boundaryImg = getImgBoundary(img);  % alternatively you can use bwboundaries() if you have image processing library

figure(1); 
subplot(121);
imagesc(img);
title('Original B&W image');
subplot(122); 
imagesc(boundaryImg);
title('Image boundaries');

[chCode, chMap] = findChainCode (boundaryImg);

chMap = chMap-1;
chCode = chCode-1;  % 0 to 7 instead of 1 to 8

figure(2); 
subplot(121); 
histogram(chCode);
title('Distribution shape of directions');
subplot(122);
imagesc(chMap);
title('Shape of directions');


function boundaryImg = getImgBoundary(bw_img) 

sz = size(bw_img);
boundaryImg = zeros(sz);

imgPadded = zeros(sz(1)+2, sz(2)+2);

imgPadded(2:end-1, 2:end-1) = bw_img;

for i = 2:sz(1)+1
    for j = 2:sz(2)+1
        if imgPadded(i,j)
            if ~imgPadded(i-1,j) || ~imgPadded(i+1,j) || ~imgPadded(i,j-1) || ~imgPadded(i,j+1)
                boundaryImg(i-1, j-1) = 1;
            end
        end
    end
end
end


