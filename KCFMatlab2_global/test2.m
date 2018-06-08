load aaaa.txt;
load hhhh.txt;
load tmpl.txt;
alphaf(:,:,1)=aaaa(:,1:2:end);
alphaf(:,:,2)=aaaa(:,2:2:end);

tmpl=tmpl;

FeatureMap=hhhh;
[res,peak_value] = Detect(tmpl,FeatureMap,alphaf);