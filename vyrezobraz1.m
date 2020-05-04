% vyrezanie obrazu z povodneho a resize na 224x224
filepath='D:\Data\Caltech\Programy';
% resnet 224x224 
polsize=(224*6)/2;
bolOK=0;
numvyr=0;
strFP=dir(filepath);

figure
for i=1:1       %length(strFP)
%     if length(strFP(i).name)>3
%     strpom=[filepath '\' strFP(i).name];

    strpom=[filepath '\P3281605.JPG'];
    Ir=imread(strpom);
%     I=imrotate(Ir,-90);

    I=Ir;
    [n,m,h]=size(I);
    bolOK=0;
    while bolOK<3
        hold off
        imshow(I)
        title('klikni do stredu objektu')
        % kliknutie do stredu objektu 
        [xs,ys]=ginput(1);
        
        % zistenie ohraniceni objektu
        s1=xs-polsize-1;
        s2=xs+polsize;
        if s1<1
            s1=1; s2=polsize*2;
        end
        if s2>m
            s1=m-polsize*2+1; s2=m;
        end
        r1=ys-polsize-1;
        r2=ys+polsize;
        if r1<1
           r1=1; r2=polsize*2;
        end
        if r2>n
            r1=n-polsize*2+1; r2=n;
        end
        hold
        % zobrazenie ohranicenia
        plot([s1 s2 s2 s1 s1],[r1 r1 r2 r2 r1],'y-')
        title('potvrd kliknutim spravnost vyrezu objektu')
        [xok,yok]=ginput(1);
        % vyrezanie objektu
        Iv=I(r1:r2,s1:s2,:);
        if xok<100
            % ak sa kliklo do laveho horneho rohu, akceptujem vyrez
            numvyr=numvyr+1;
            Ire=imresize(Iv,[224 224]);
            strpom1=[filepath '\export_cup\cupfoto2_' num2str(i) '_' num2str(numvyr) '.JPG'];
            imwrite(Ire,strpom1,'JPEG')
            bolOK=0;
        elseif xok>m-100 
            % ak sa kliklo do praveho horneho rohu, opakuj vyrez
            
%             numvyr=numvyr+1;
%             strpom1=[filepath '\skup1\parafoto1_' num2str(i) '_' num2str(numvyr) '.JPG'];
%             imwrite(Iv,strpom1,'JPEG')
            bolOK=1;       
%         elseif yok<n/2
%             bolOK=2;
        else
            % ak sa kliklo inde, koniec, novy obraz
            
            bolOK=3;
        end
    end
%     end
end
    
    
    