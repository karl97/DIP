function thresh = getThreshold(simMatrix)
    mu=mean(simMatrix,'all');
    sigma=std(simMatrix,0,'all');
    thresh=mu+2*sigma;%setting the threshold to two times the standard deviation relative to the mean
end

