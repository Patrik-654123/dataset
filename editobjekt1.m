% Program na naklikanie rohov objektov v obraze
% najprv klikat pracy horny roh, potom pravy dolny a nakoniec sirku objektu
% ak sa pomylite pri klikani treba kliknut parny pocet bodov
% na potvrdenie stlacit ENTER
filepath='/Users/Patrik/Downloads/Programy_oznacobjekt/export_cup';


strFP=dir(filepath);
% resnet 224x224 
bolOK=0;
tabParam=cell(length(strFP),2); % premenna na parametre objektov
k=1;
figure
for i=1:length(strFP)
    if contains(strFP(i).name,"JPG",'IgnoreCase',true)==1
        strpom=[filepath '/' strFP(i).name];
        I=imread(strpom);
        
        [n,m,h]=size(I);
        bolOK=0;
        while bolOK<1
            hold off
            imshow(I)
            title('klikni horny pravy roh, dolny pravy roh, potom vydialenost od objektu , potom enter')
            [xs,ys]=ginput;     % ak si neklikol spravne klikni, parny pocet bodov
            hold
            if rem(length(xs),3)==0  
             xn=[];
             yn=[]; 
             for j=1:3:length(xs)    
                 alfa=atand(abs(ys(j)-ys(j+1))/abs(xs(j)-xs(j+1)));
                 if(xs(j)<xs(j+1))
                     alfa=180-alfa;
                 end
                 
                 v=[xs(j+1)-xs(j),ys(j+1)-ys(j)];
                 n=[-v(2),v(1)];
                 c=-n(1)*xs(j)-n(2)*ys(j);
                 
                 a=abs(n(1)*xs(j+2)+n(2)*ys(j+2)+c)/sqrt(n(1)^2+n(2)^2);
                 
                 xn=[xn; xs(j); xs(j+1); xs(j+1)-cosd(90-alfa)*a; xs(j)-cosd(90-alfa)*a];
                 yn=[yn; ys(j); ys(j+1); ys(j+1)-sind(90-alfa)*a; ys(j)-sind(90-alfa)*a];
             end
             
                tabParam{k,1}=strFP(i).name;    % 1. bunka - meno subora
                tabParam{k,2}=[xn yn];          % 2. bunka - pozicie naklikanych rohov obrazov
                
                % matica s 2 stlpcami [x y] [stlpec riadok] v obraze,
                % neparny riadok horny roh, parny riadok dolny roh objektu
                k=k+1;
                bolOK=1;
            end
        end
            
    end
end
pocetobrazov=k-1;
%save datarohov_objekt1 tabParam pocetobrazov

    
    