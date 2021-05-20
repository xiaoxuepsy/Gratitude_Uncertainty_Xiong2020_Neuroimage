clear
clc

FolderPath = 'Z:\XiongWei\GRA\first_level_contrast_conjuction';
OutputPath = 'Z:\XiongWei\GRA\Flexible_all';
if ~exist(OutputPath,'dir')
        mkdir(OutputPath);
end

SubList = dir(fullfile(FolderPath,'Z*'));

for nsub = 1:length(SubList)
    
    s = regexp(SubList(nsub).name,'_','split');
    subnum = s(3);
    SubList(nsub).name

    SubOutput = fullfile(FolderPath,SubList(nsub).name);
    
    
    
    %%_________Copy file__________%%

    copyfile(fullfile(SubOutput,'contrast1_con1_hum_know_share',[SubList(nsub).name,'_con_0001.img']),fullfile(OutputPath,[SubList(nsub).name,'_con_0001.img']));
    copyfile(fullfile(SubOutput,'contrast1_con1_hum_know_share',[SubList(nsub).name,'_con_0001.hdr']),fullfile(OutputPath,[SubList(nsub).name,'_con_0001.hdr']));
    copyfile(fullfile(SubOutput,'contrast2_con3_com_know_share',[SubList(nsub).name,'_con_0002.img']),fullfile(OutputPath,[SubList(nsub).name,'_con_0002.img']));
    copyfile(fullfile(SubOutput,'contrast2_con3_com_know_share',[SubList(nsub).name,'_con_0002.hdr']),fullfile(OutputPath,[SubList(nsub).name,'_con_0002.hdr']));
    copyfile(fullfile(SubOutput,'contrast3_con5_hum_risk_share',[SubList(nsub).name,'_con_0003.img']),fullfile(OutputPath,[SubList(nsub).name,'_con_0003.img']));
    copyfile(fullfile(SubOutput,'contrast3_con5_hum_risk_share',[SubList(nsub).name,'_con_0003.hdr']),fullfile(OutputPath,[SubList(nsub).name,'_con_0003.hdr']));
    copyfile(fullfile(SubOutput,'contrast4_con7_com_risk_share',[SubList(nsub).name,'_con_0004.img']),fullfile(OutputPath,[SubList(nsub).name,'_con_0004.img']));
    copyfile(fullfile(SubOutput,'contrast4_con7_com_risk_share',[SubList(nsub).name,'_con_0004.hdr']),fullfile(OutputPath,[SubList(nsub).name,'_con_0004.hdr']));
    copyfile(fullfile(SubOutput,'contrast5_con9_hum_ambi_share',[SubList(nsub).name,'_con_0005.img']),fullfile(OutputPath,[SubList(nsub).name,'_con_0005.img']));
    copyfile(fullfile(SubOutput,'contrast5_con9_hum_ambi_share',[SubList(nsub).name,'_con_0005.hdr']),fullfile(OutputPath,[SubList(nsub).name,'_con_0005.hdr']));
    copyfile(fullfile(SubOutput,'contrast6_con11_com_ambi_share',[SubList(nsub).name,'_con_0006.img']),fullfile(OutputPath,[SubList(nsub).name,'_con_0006.img']));
    copyfile(fullfile(SubOutput,'contrast6_con11_com_ambi_share',[SubList(nsub).name,'_con_0006.hdr']),fullfile(OutputPath,[SubList(nsub).name,'_con_0006.hdr']));
%    
end
