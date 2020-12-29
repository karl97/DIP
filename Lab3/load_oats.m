function images = load_oats()
%load all filenames from their folders
got=dir('Oats/Gotala 50 corns/*.*');
lan=dir('Oats/Lanna 50 corns/*.*');
mul=dir('Oats/Multorp 50 corns/*.*');

s=struct('file_name','','farm','','image',0,'cultivation',0,'type',0);%struct to hold all information
imc=1;%counter for all images
%filling all data from gotala
images=cell(1,66);
for i=3:length(got)
    s.file_name=got(i).name;
    s.farm='got';
    s.image=imrotate((imread(strcat('Oats/Gotala 50 corns/',got(i).name))),-90);
    s.cultivation=get_cult(got(i).name);
    s.type=get_type(got(i).name);
    images(imc)={s};
    imc=imc+1;
end
%filling all data from lanna
for i=3:length(lan)
    s.file_name=lan(i).name;
    s.farm='lan';
    s.image=imrotate((imread(strcat('Oats/Lanna 50 corns/',lan(i).name))),-90);
    s.cultivation=get_cult(lan(i).name);
    s.type=get_type(lan(i).name);
    images(imc)={s};
    imc=imc+1;
end
%filling all data from multorp
for i=3:length(mul)
    s.file_name=mul(i).name;
    s.farm='mul';
    s.image=imrotate((imread(strcat('Oats/Multorp 50 corns/',mul(i).name))),-90);
    s.cultivation=get_cult_mul(mul(i).name);
    s.type=get_type(mul(i).name);
    images(imc)={s};
    imc=imc+1;
end


end

%search name for cultivation type
function out=get_cult(name)
    name=lower(name);
    if(contains(name,'fat'))
        out=1;
    elseif(contains(name,'bel'))
        out=2;
    elseif(contains(name,'symp'))
        out=3;
    else
        out=0;
    end
end
%search name for type
function out=get_type(name)
    name=lower(name);
    if(contains(name,'huv'))
        out=1;
    elseif(contains(name,'grn'))
        out=2;
    else
        out=0;
    end
end
%search name to add cultivation type to multorp images
function out=get_cult_mul(name)
    name=lower(name);
    if(contains(name,["63","65","69","71","72"]))%63-72,fat
        out=1;
    elseif(contains(name,["mul 50","53","54","56","59"]))%50-59,bel
        out=2;
    elseif(contains(name,["74","77","78","80","83"]))%74-83,symp
        out=3;
    else
        out=0;
    end
end