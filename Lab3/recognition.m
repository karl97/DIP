function bestMatch = recognition(index)
I = imread(sprintf('recognition/query/QueryImage%i.jpg',index));%load image with correct image
Ig = rgb2gray(I);

%getting the features for the chosen image
ptsI = detectSURFFeatures(Ig);
[feats1, validPts1] = extractFeatures(Ig,ptsI);

for i=1:20%looking through the database and calculating matches of features 
    dbI = imread(sprintf('recognition/database/DatabaseImage%i.jpg',i));
    dbI = rgb2gray(dbI);
    ptsdbI = detectSURFFeatures(dbI);
    [featsdbI, validPtsdbI] = extractFeatures(dbI,ptsdbI);
    indexPairs(i) = length(matchFeatures(feats1,featsdbI,'MatchThreshold',100,'MaxRatio',0.3));
end

%getting the best match based on most matched features
bestVal=max(indexPairs);
bestIndex=find(indexPairs==bestVal); %the best image match index 
bestI = imread(sprintf('recognition/database/DatabaseImage%i.jpg',bestIndex)); %getting the image
bestIg = rgb2gray(bestI);

%displaying the best match with the query image and their matched features
pts2 = detectSURFFeatures(bestIg);
[feats2,validPts2] = extractFeatures(bestIg,pts2);
indexPairs = matchFeatures(feats1,feats2,'MatchThreshold',100,'MaxRatio',0.3);
matchedPoints1 = validPts1(indexPairs(:, 1));
matchedPoints2 = validPts2(indexPairs(:, 2));
figure;showMatchedFeatures(I,bestI,matchedPoints1,matchedPoints2,'montage')

bestMatch=bestI;
end

