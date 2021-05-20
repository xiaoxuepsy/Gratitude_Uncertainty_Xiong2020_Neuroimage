clear
clc

SPM=[];
datapfad='Z:\XiongWei\GRA\first_level_contrast_conjuction';%%%%%%%%%%%

subjects = dir(fullfile(datapfad,'Z*'));

Betas=zeros(38,6);%%%%(nparticipant,ncondition)

nrsub=length(subjects);

% center=[33 44 -5];
center=[0 29 55];





for subnr=1:nrsub
    
    subjects(subnr).name
    
    runnum=[];

    datapath= fullfile(datapfad, subjects (subnr).name);
 

    P1 = fullfile(datapath,'con_0001.img'); 
    P2 = fullfile(datapath,'con_0002.img');
    P3 = fullfile(datapath,'con_0003.img');
    P4 = fullfile(datapath,'con_0004.img');
    
    P5 = fullfile(datapath,'con_0005.img'); 
    P6 = fullfile(datapath,'con_0006.img');


    V1	=	spm_vol(	P1	);
    V2	=	spm_vol(	P2	);
    V3	=	spm_vol(	P3	);
    V4	=	spm_vol(	P4	);
    V5	=	spm_vol(	P5	);
    V6	=	spm_vol(	P6	);


   

    for x = 1:3
        for y =1:3
            for z = 1:3
                coord = [center(1)+3*(x-2), center(2)+3*(y-2), center(3)+3*(z-2)];
                
                
                MNI=coord;
                coord = V1(1).mat\[MNI';ones(1,size(MNI',2))];
                
                Val_con1 = spm_sample_vol(V1(1),coord(1),coord(2),coord(3),0);
                
                Val_con2 = spm_sample_vol(V2(1),coord(1),coord(2),coord(3),0);
                
                Val_con3 = spm_sample_vol(V3(1),coord(1),coord(2),coord(3),0);
                
                Val_con4 = spm_sample_vol(V4(1),coord(1),coord(2),coord(3),0);
                
                Val_con5 = spm_sample_vol(V5(1),coord(1),coord(2),coord(3),0);
                
                Val_con6 = spm_sample_vol(V6(1),coord(1),coord(2),coord(3),0);


                
                
                Betas(subnr,1)=Betas(subnr,1)+ Val_con1;
                Betas(subnr,2)=Betas(subnr,2)+ Val_con2;
                Betas(subnr,3)=Betas(subnr,3)+ Val_con3;
                Betas(subnr,4)=Betas(subnr,4)+ Val_con4;
                Betas(subnr,5)=Betas(subnr,5)+ Val_con5;
                Betas(subnr,6)=Betas(subnr,6)+ Val_con6;

                
                
            end;
        end
    end
end
Betas=Betas/27;

