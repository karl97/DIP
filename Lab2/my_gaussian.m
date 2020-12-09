function filter = my_gaussian(size)
filter=zeros(size);
middle=(size-1)/2+1;
%creates a gaussian based ondistance from the middle oif the filter
for i=1:size
    for j=1:size
        filter(i,j)=normpdf(sqrt((i-middle)^2+(j-middle)^2),0,size/2);
    end
end
filter=filter/sum(filter,'all');

end

