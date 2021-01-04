function s = get_all_stats(bin,I)
%all stats to be collected
s=struct('average_area',0,'median_area',0,'average_major_axis',0,'median_major_axis',0,'average_minor_axis',0,'median_minor_axis',0,'average_RGB',zeros(1,3),'median_RGB',zeros(1,3),'average_HSV',zeros(1,3),'median_HSV',zeros(1,3));

%get all stats and fill data structure
[s.average_area,s.median_area,sigma]=bin_area_stats(bin);
[s.average_major_axis,s.median_major_axis,sigma]=bin_max_axis_stats(bin);
[s.average_minor_axis,s.median_minor_axis,sigma]=bin_min_axis_stats(bin);
[s.average_RGB,s.median_RGB,sigma]=color_stats(bin,I);
[s.average_HSV,s.median_HSV,sigma]=color_stats(bin,rgb2hsv(I));
%convert all to mm from pixels
s=to_mm(s);
end

function out=to_mm(in)
n=1000*(1/400)/14; %one pixel size
f = fieldnames(in);
for i=1:6 
    in.(f{i})=in.(f{i})*n;
end
out=in;
end