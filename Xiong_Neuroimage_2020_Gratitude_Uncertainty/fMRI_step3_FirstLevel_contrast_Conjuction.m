clear
clc
spm fmri

FolderPath = 'Z:\XiongWei\GRA\convert';
OutputPath = 'Z:\XiongWei\GRA\first_level_contrast_conjuction';

cd('Z:\XiongWei\batch\xw_bacth');
% onset file name
pain_onset

NSlice = 40;
refSlice = 39;
TR = 2.0;
SubList = dir(fullfile(FolderPath,'Z*'));
CondList = {'con1_outcome_onset' 'con3_outcome_onset' 'con5_outcome_onset' 'con7_outcome_onset' 'con9_outcome_onset' 'con11_outcome_onset' 'con2_outcome_onset' 'con4_outcome_onset' 'con6_outcome_onset' 'con8_outcome_onset' 'con10_outcome_onset' 'con12_outcome_onset' 'desicion_onset' 'allocation_onset' };  %% conresponding to onset condition
%Note
%con1_hum_certain_share con3_com_certain_share  con5_hum_risk_share con7_com_risk_share con9_hum_ambi_share con11_com_ambi_share
%con2_hum_certain_noshare con4_com_certain_noshare  con6_hum_risk_noshare con8_com_risk_noshare con10_hum_ambi_noshare con12_com_ambi_noshare

Parametric_under_condition = {};


Nuisance = {};% irrelevant event , filler event   'errors'

cname = {  'con1_hum_certain_share' 'con3_com_certain_share' 'con5_hum_risk_share' 'con7_com_risk_share' 'con9_hum_ambi_share' 'con11_com_ambi_share'  'con2_hum_certain_noshare' 'con4_com_certain_noshare' 'con6_hum_risk_noshare' 'con8_com_risk_noshare' 'con10_hum_ambi_noshare' 'con12_com_ambi_noshare'};

ctype = {'T' , 'T', 'T', 'T','T' , 'T', 'T', 'T','T' , 'T', 'T', 'T'};
    
%               hks cks  hrs crs has cas
simple_cons = [               
                 1 0 0 0 0 0   0 0 0 0 0 0  0 0;
                 0 1 0 0 0 0   0 0 0 0 0 0  0 0;
                 0 0 1 0 0 0   0 0 0 0 0 0  0 0;
                 0 0 0 1 0 0   0 0 0 0 0 0  0 0;
                 0 0 0 0 1 0   0 0 0 0 0 0  0 0;
                 0 0 0 0 0 1   0 0 0 0 0 0  0 0;
                 0 0 0 0 0 0   1 0 0 0 0 0  0 0;
                 0 0 0 0 0 0   0 1 0 0 0 0  0 0;
                 0 0 0 0 0 0   0 0 1 0 0 0  0 0;
                 0 0 0 0 0 0   0 0 0 1 0 0  0 0;
                 0 0 0 0 0 0   0 0 0 0 1 0  0 0;
                 0 0 0 0 0 0   0 0 0 0 0 1  0 0;  ];

para_cons = [];
% run SPM


for nsub = 1:length(SubList)
    %ZXL_XW_sub115_Yangyucheng
    s = regexp(SubList(nsub).name,'_','split');
    subnum = s(3);%'sub115'
    SubList(nsub).name
    
    
    SubOutput = fullfile(OutputPath,SubList(nsub).name);
    if ~exist(SubOutput,'dir')
        mkdir(SubOutput);
    end
    for c= 1:length(cname)
        contrast_dir{c} = fullfile(SubOutput,['contrast',num2str(c),'_',char(cname{c})]);
        if ~exist(contrast_dir{c})
            mkdir(contrast_dir{c});
        end
    end
    
    Checkfolder = fullfile(SubOutput,'ChkMsg2EstimateDone');
    RunList = dir(fullfile(FolderPath,SubList(nsub).name,'*GRA*')); %2015-05-20
    
    
    sub =SubList(nsub).name ;
    
    
    clear matlabbatch;
    
    matlabbatch{1}.spm.stats.fmri_spec.dir = {SubOutput};
    matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'scans';  %'secs'
    
    matlabbatch{1}.spm.stats.fmri_spec.timing.RT = TR;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = NSlice;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = refSlice;
    
    
    
    for nrun = 1:length(RunList)
        
        clear Files FileList FilePath;
        FilePath = fullfile(FolderPath,SubList(nsub).name,RunList(nrun).name);
        FileList = dir(fullfile(FilePath,'swra*.nii'));
        
       
        for nfile = 1:length(FileList)
            Files(nfile) = {fullfile(FilePath,FileList(nfile).name)};
        end
        matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).scans = Files;
        
        
        cond_num = length(CondList);
        
        
        for ncond = 1:cond_num
            matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).cond(ncond).name = CondList{ncond};
            if ncond < 13
                matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).cond(ncond).onset = eval([subnum{1} '_' sprintf('run%d',nrun) '_' CondList{ncond}]);
          elseif ncond == 13
                matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).cond(ncond).onset = [eval([subnum{1} '_' sprintf('run%d',nrun) '_con2_desicion_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con4_desicion_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con6_desicion_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con8_desicion_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con10_desicion_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con12_desicion_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con1_desicion_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con3_desicion_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con5_desicion_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con7_desicion_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con9_desicion_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con11_desicion_onset'])];
            elseif ncond == 14
                matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).cond(ncond).onset = [eval([subnum{1} '_' sprintf('run%d',nrun) '_con2_allocation_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con4_allocation_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con6_allocation_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con8_allocation_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con10_allocation_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con12_allocation_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con1_allocation_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con3_allocation_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con5_allocation_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con7_allocation_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con9_allocation_onset']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con11_allocation_onset'])];
            
            end    
            matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).cond(ncond).tmod = 0;
            %%%%--------------2015-06-09------------
            if ncond < 13
                matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).cond(ncond).duration = 3/2;
            elseif ncond == 13
                matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).cond(ncond).duration = 2/2;
            elseif ncond == 14
                matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).cond(ncond).duration =  [eval([subnum{1} '_' sprintf('run%d',nrun) '_con2_response_duration']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con4_response_duration']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con6_response_duration']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con8_response_duration']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con10_response_duration']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con12_response_duration']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con1_response_duration']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con3_response_duration']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con5_response_duration']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con7_response_duration']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con9_response_duration']) eval([subnum{1} '_' sprintf('run%d',nrun) '_con11_response_duration'])];
%           
            end
            %%%%--------------2015-06-09------------
            if isempty(Parametric_under_condition)
                matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).cond(ncond).pmod = struct('name', {}, 'param', {}, 'poly', {});
            else
                
                if ncond == 1
                    for p_c = 1:length(Parametric_under_condition)
                        p_c
                        
                        matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).cond(ncond).pmod(p_c).name = char(Parametric_under_condition{p_c});
                        matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).cond(ncond).pmod(p_c).param = eval([sprintf('sub%s',subnum{1}) '_' sprintf('run%d',nrun) '_' CondList{ncond} '_' Parametric_under_condition{p_c}]);
                        matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).cond(ncond).pmod(p_c).poly = 1;
                    end
                else
                    matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).cond(ncond).pmod = struct('name', {}, 'param', {}, 'poly', {});
                end
            end
        end
        
        
        matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).multi = {''};
        matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).regress = struct('name', {}, 'val', {});
        MultiReg = dir(fullfile(FilePath,'rp_a*.txt'));
        matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).multi_reg = {fullfile(FilePath,MultiReg.name)};
        matlabbatch{1}.spm.stats.fmri_spec.sess(nrun).hpf = 128;
    end
    matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
    matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0]; %  [1 0]  %%%% 2015-05-20
    matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
    matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
    matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
    matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
    
    if ~exist(Checkfolder,'dir')
        spm_jobman('run',matlabbatch);
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% estimate model %%%%%%%%%%%%%%%%%%%%%
    
    clear matlabbatch;
    matlabbatch{1}.spm.stats.fmri_est.spmmat = {fullfile(SubOutput,'SPM.mat')};
    spm_jobman('run',matlabbatch);
    mkdir(Checkfolder);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% define contrasts%%%%%%%%%%%%%%%%%%%%
    Checkfolder = fullfile(SubOutput,'ChkMsg2ContrastDone');
    if exist(Checkfolder,'dir')
    else
        SPMest=load(fullfile(SubOutput,'SPM.mat'));
        SPMest=SPMest.SPM;
        SPMest.xCon = [];
        headmotion_constant = [0 0 0 0 0 0];
        for c= 1:length(cname)
            cons = [];
            
            for r = 1:length(RunList)
                
                combined_cons = [];
                run_cons = [];
                
                for s_c = 1:length(simple_cons(c,:))
                    if s_c == 999
                        combined_cons = [combined_cons simple_cons(c,s_c)  para_cons(c,:)  ];  %combined_cons = [combined_cons simple_cons(c,s_c)  0 0 0];
                    else
                        combined_cons = [combined_cons simple_cons(c,s_c)  ] ;  %combined_cons = [combined_cons simple_cons(c,s_c) 0 ]
                    end
                end
                %%%%----------------------
                
                run_cons = [combined_cons  headmotion_constant];
                
                cons = [cons run_cons];
            end

            cons = [cons zeros(1,length(RunList))];
           
            %cons = [cons zeros(1,length(lrun))];
            contrast(c).cname = char(cname(c));
            contrast(c).ctype = char(ctype(c));
            %cons = [cons 0 0];
            contrast(c).cons = cons';
            
            if isempty(SPMest.xCon)
                SPMest.xCon = spm_FcUtil('Set',contrast(c).cname, contrast(c).ctype,'c',contrast(c).cons,SPMest.xX.xKXs);
            else
                SPMest.xCon (end+1) = spm_FcUtil('Set',contrast(c).cname, contrast(c).ctype,'c',contrast(c).cons,SPMest.xX.xKXs);
            end
            dlmwrite(fullfile(SubOutput,[SubList(nsub).name,'_contrast',num2str(c),'.txt']), cons','delimiter','\t');
        end
        spm_contrasts(SPMest);
        save(fullfile(SubOutput,[SubList(nsub).name,'_','1stLevel_contrast.mat']),'contrast');
        
        
        %% copy contrast files
        for c= 1:length(cname)
            sourcefile = ['con_',strrep(num2str(c+100000000),'10000','')];
            copyfile(fullfile(SubOutput,[sourcefile,'.img']),fullfile(contrast_dir{c},[SubList(nsub).name,'_',sourcefile,'.img']));
            copyfile(fullfile(SubOutput,[sourcefile,'.hdr']),fullfile(contrast_dir{c},[SubList(nsub).name,'_',sourcefile,'.hdr']));
        end
        
        mkdir(Checkfolder);
    end
end