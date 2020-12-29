function [mu,median_,sigma] = color_stats(bin,I)
bin=bin==1;%convert to logical
%get hsv or rgb components
Irgb(1)={I(:,:,1)};
Irgb(2)={I(:,:,2)};
Irgb(3)={I(:,:,3)};

mu=zeros(1,3);
median_=zeros(1,3);
sigma=zeros(1,3);
for i=1:3
    temp=Irgb{i};%get r or g or b / h or s or v components
    %only get mean in the filtered areas
    mu(1,i)=mean(temp(bin),'all');
    median_(1,i)=median(temp(bin),'all');
    sigma(1,i)=std(temp(bin),[],'all');
end

end

