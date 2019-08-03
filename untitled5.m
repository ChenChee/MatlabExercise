%%网页上找的https://blog.csdn.net/hit1524468/article/details/48914291
% 原图像
original = imread('licl二值化.jpg'); 
imshow(original); 
title('原图'); 
% 退化图像
distorted = imresize(original,0.7); 
distorted = imrotate(distorted,31); 
figure; 
imshow(distorted); 
title('缩小旋转'); 
% 提取SURF特征点
ptsOriginal = detectSURFFeatures(original); 
ptsDistorted = detectSURFFeatures(distorted); 
% 获取描述子
[featuresOriginal,validPtsOriginal] = extractFeatures(original,ptsOriginal); 
[featuresDistorted,validPtsDistorted] = extractFeatures(distorted,ptsDistorted);
% 描述子匹配
index_pairs = matchFeatures(featuresOriginal,featuresDistorted); 

% 匹配的特征点
matchedPtsOriginal = validPtsOriginal(index_pairs(:,1)); 
matchedPtsDistorted = validPtsDistorted(index_pairs(:,2)); 

%显示匹配结果
figure;
showMatchedFeatures(original,distorted,matchedPtsOriginal,matchedPtsDistorted);
title('匹配特征值'); 

%估计几何变换矩阵
[tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,'similarity'); 
figure;
showMatchedFeatures(original,distorted,inlierPtsOriginal,inlierPtsDistorted); 
title('匹配正确特征值'); 

%反变换图像 
outputView = imref2d(size(original)); 
Ir = imwarp(distorted,tform,'OutputView',outputView); 
figure; 
imshow(Ir); 
title('转回去'); 
title('66666~~~');