function specialImages = classifySpecialImages(images,percentageOver,t)
sim=getSimMatrix(images);
[m,n]=size(sim);
specialImages={};%to save the special images in
specialCounter=1;%counting the found special images

%going through the whole similiarity matrix
for i=1:m
    counter=0;%counting the times an image similarity is over the threshold
    for j=1:n
        if(sim(i,j)>t)
        counter=counter+1;
        end
    end
    if((counter/n)>percentageOver)%if a certain percentage of similarities is over the threshold it is clasiified as a special image
        specialImages(specialCounter,1)=images(i,1);
        specialCounter=specialCounter+1;
    end
end

end

