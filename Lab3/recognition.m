function bestMatch = recognition(index)
I = imread(sprintf('recognition/query/QueryImage%i.jpg',index));
Ig = rgb2gray(I);
ptsI = detectSURFFeatures(Ig);
[feats1, validPts1] = extractFeatures(Ig,ptsI);
for i=1:20
    dbI = imread(sprintf('recognition/database/DatabaseImage%i.jpg',i));
    dbI = rgb2gray(dbI);
    ptsdbI = detectSURFFeatures(dbI);
    [featsdbI, validPtsdbI] = extractFeatures(dbI,ptsdbI);
    indexPairs(i) = length(matchFeatures(feats1,featsdbI,'MatchThreshold',100,'MaxRatio',0.3));
end
bestVal=max(indexPairs);
bestIndex=find(indexPairs==bestVal);
bestI = imread(sprintf('recognition/database/DatabaseImage%i.jpg',bestIndex));
bestIg = rgb2gray(bestI);

pts2 = detectSURFFeatures(bestIg);
[feats2,validPts2] = extractFeatures(bestIg,pts2);

indexPairs = matchFeatures(feats1,feats2,'MatchThreshold',100,'MaxRatio',0.3);
matchedPoints1 = validPts1(indexPairs(:, 1));
matchedPoints2 = validPts2(indexPairs(:, 2));
figure;showMatchedFeatures(I,bestI,matchedPoints1,matchedPoints2,'montage')

bestMatch=bestI;
end

