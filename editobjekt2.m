% zobrazenie oznacenia objektov - boxov

load datarohov_objekt1
filepath='/Users/Patrik/Documents/1.Ing/LS/OP/Programy_oznacobjekt 2/export_cup';

%pt=size(tabParam,1)-2;
pt=pocetobrazov;

%varNames = {'imageFilename','Cup'};

B=cell(pt,2);   % vytvorenie celu pre boxy objektov
for i=1:pt

strpom=[filepath '/' tabParam{i,1}];

I=imread(strpom);
boxParam=tabParam{i,2};
bbox=[];
% prejdi vsetky objekty
for j=1:4:size(boxParam,1)
    bbox=[bbox; boxParam(j,1),boxParam(j,2),boxParam(j+1,1),boxParam(j+1,2),boxParam(j+2,1),boxParam(j+2,2),boxParam(j+3,1),boxParam(j+3,2)];
    
    
end
annotatedImage = insertShape(I,'Polygon',bbox);
 
B{i,1}=tabParam{i,1};   % meno subora
B{i,2}=bbox;            % parametre boxov

h=figure;
imshow(annotatedImage)
title(num2str(i))
pause
close(h)
end

tableCupBoxs=cell2table(B);

% save databox_objekt1 B tableCupBoxs

    
    
    