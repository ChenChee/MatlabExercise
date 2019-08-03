%%��ҳ���ҵ�https://blog.csdn.net/hit1524468/article/details/48914291
% ԭͼ��
original = imread('licl��ֵ��.jpg'); 
imshow(original); 
title('ԭͼ'); 
% �˻�ͼ��
distorted = imresize(original,0.7); 
distorted = imrotate(distorted,31); 
figure; 
imshow(distorted); 
title('��С��ת'); 
% ��ȡSURF������
ptsOriginal = detectSURFFeatures(original); 
ptsDistorted = detectSURFFeatures(distorted); 
% ��ȡ������
[featuresOriginal,validPtsOriginal] = extractFeatures(original,ptsOriginal); 
[featuresDistorted,validPtsDistorted] = extractFeatures(distorted,ptsDistorted);
% ������ƥ��
index_pairs = matchFeatures(featuresOriginal,featuresDistorted); 

% ƥ���������
matchedPtsOriginal = validPtsOriginal(index_pairs(:,1)); 
matchedPtsDistorted = validPtsDistorted(index_pairs(:,2)); 

%��ʾƥ����
figure;
showMatchedFeatures(original,distorted,matchedPtsOriginal,matchedPtsDistorted);
title('ƥ������ֵ'); 

%���Ƽ��α任����
[tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,'similarity'); 
figure;
showMatchedFeatures(original,distorted,inlierPtsOriginal,inlierPtsDistorted); 
title('ƥ����ȷ����ֵ'); 

%���任ͼ�� 
outputView = imref2d(size(original)); 
Ir = imwarp(distorted,tform,'OutputView',outputView); 
figure; 
imshow(Ir); 
title('ת��ȥ'); 
title('66666~~~');