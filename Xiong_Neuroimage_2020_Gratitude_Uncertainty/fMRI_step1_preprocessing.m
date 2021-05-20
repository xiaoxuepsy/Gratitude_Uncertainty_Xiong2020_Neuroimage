clear;
clc;
spm fmri

func_path = 'Z:\XiongWei\GRA\convert\new';  
spm_dir = 'C:\Toolbox\spm8';   


folderstruct = dir(fullfile(func_path,'Z*'));  
FunImg_sublist = {};

for i = 1:length(folderstruct)   
    subj{i} = folderstruct(i).name;
end;
%%
for Si = 1:length(subj)    

    clear zatlabbatch;
% %     
    data_f1 = [];
    data_a1 = [];
    data_r1 = [];
    data_w1 = [];
    
    data_f2 = [];
    data_a2 = [];
    data_r2 = [];
    data_w2 = [];
    
    data_f3 = [];
    data_a3 = [];
    data_r3 = [];
    data_w3 = [];

    data_f4 = [];
    data_a4 = [];
    data_r4 = [];
    data_w4 = [];


    % %     
    run_path = fullfile(func_path,subj{Si});
    
    
    run_name = dir(fullfile(func_path,subj{Si},'*RUN1*'));

    run1_files = dir(fullfile(run_path,run_name.name,'*GRA*.nii'));
    for i = 1:length(run1_files)
        data_f1 = [data_f1;fullfile(run_path,run_name.name),'\',[run1_files(i).name],',1'];
        data_a1 = [data_a1;fullfile(run_path,run_name.name),'\a',[run1_files(i).name],',1'];
        data_r1 = [data_r1;fullfile(run_path,run_name.name),'\ra',[run1_files(i).name],',1'];
        data_w1 = [data_w1;fullfile(run_path,run_name.name),'\wra',[run1_files(i).name],',1'];
    end;
    
%         data_f1 (1:5,:) = [];
%         data_a1 (1:5,:) = [];
%         data_r1 (1:5,:) = [];
%         data_w1 (1:5,:) = [];

    
    run_name = dir(fullfile(func_path,subj{Si},'*RUN2*'));

    run2_files = dir(fullfile(run_path,run_name.name,'*GRA*.nii'));
    for i = 1:length(run2_files)
        data_f2 = [data_f2;fullfile(run_path,run_name.name),'\',[run2_files(i).name],',1'];
        data_a2 = [data_a2;fullfile(run_path,run_name.name),'\a',[run2_files(i).name],',1'];
        data_r2 = [data_r2;fullfile(run_path,run_name.name),'\ra',[run2_files(i).name],',1'];
        data_w2 = [data_w2;fullfile(run_path,run_name.name),'\wra',[run2_files(i).name],',1'];
    end;
    
%         data_f2 (1:5,:) = [];
%         data_a2 (1:5,:) = [];
%         data_r2 (1:5,:) = [];
%         data_w2 (1:5,:) = [];
%     
    run_name = dir(fullfile(func_path,subj{Si},'*RUN3*'));

    run3_files = dir(fullfile(run_path,run_name.name,'*GRA*.nii'));
    for i = 1:length(run3_files)
        data_f3 = [data_f3;fullfile(run_path,run_name.name),'\',[run3_files(i).name],',1'];
        data_a3 = [data_a3;fullfile(run_path,run_name.name),'\a',[run3_files(i).name],',1'];
        data_r3 = [data_r3;fullfile(run_path,run_name.name),'\ra',[run3_files(i).name],',1'];
        data_w3 = [data_w3;fullfile(run_path,run_name.name),'\wra',[run3_files(i).name],',1'];
    end;
    
%         data_f3 (1:5,:) = [];
%         data_a3 (1:5,:) = [];
%         data_r3 (1:5,:) = [];
%         data_w3 (1:5,:) = [];

    run_name = dir(fullfile(func_path,subj{Si},'*RUN4*'));
    run4_files = dir(fullfile(run_path,run_name.name,'*GRA*.nii'));

    for i = 1:length(run4_files)
        data_f4 = [data_f4;fullfile(run_path,run_name.name),'\',[run4_files(i).name],',1'];
        data_a4 = [data_a4;fullfile(run_path,run_name.name),'\a',[run4_files(i).name],',1'];
        data_r4 = [data_r4;fullfile(run_path,run_name.name),'\ra',[run4_files(i).name],',1'];
        data_w4 = [data_w4;fullfile(run_path,run_name.name),'\wra',[run4_files(i).name],',1'];
    end;
    
%         data_f4 (1:5,:) = [];
%         data_a4 (1:5,:) = [];
%         data_r4 (1:5,:) = [];
%         data_w4 (1:5,:) = [];
       
        
        data_a = [];
        data_r = [];
        data_w = [];

      for runi = 1:4
        data_a = [data_a;cellstr(eval(strcat('data_a',num2str(runi))))];
        data_r = [data_r;cellstr(eval(strcat('data_r',num2str(runi))))];
        data_w = [data_w;cellstr(eval(strcat('data_w',num2str(runi))))];
      end

    %_______SLICE TIMING_______
    zatlabbatch{1,1}.spm.temporal.st.scans{1,1} = cellstr(data_f1);
    zatlabbatch{1,1}.spm.temporal.st.scans{1,2} = cellstr(data_f2);
    zatlabbatch{1,1}.spm.temporal.st.scans{1,3} = cellstr(data_f3);
    zatlabbatch{1,1}.spm.temporal.st.scans{1,4} = cellstr(data_f4);

    
      
    zatlabbatch{1,1}.spm.temporal.st.nslices = 40;
    zatlabbatch{1,1}.spm.temporal.st.tr = 2;
    zatlabbatch{1,1}.spm.temporal.st.ta = 2-2/40;
    zatlabbatch{1,1}.spm.temporal.st.so = [1:2:40 2:2:40];
    zatlabbatch{1,1}.spm.temporal.st.refslice = 39;
    zatlabbatch{1,1}.spm.temporal.st.prefix = 'a';
    
    %_______REALIGN: Estimation and Reslice_______
    zatlabbatch{1,2}.spm.spatial.realign.estimate.data{1,1} = cellstr(data_a1);
    zatlabbatch{1,2}.spm.spatial.realign.estimate.data{1,2} = cellstr(data_a2);
    zatlabbatch{1,2}.spm.spatial.realign.estimate.data{1,3} = cellstr(data_a3);
    zatlabbatch{1,2}.spm.spatial.realign.estimate.data{1,4} = cellstr(data_a4);
    
    
    zatlabbatch{1,2}.spm.spatial.realign.estimate.eoptions.quality = 0.9;
	zatlabbatch{1,2}.spm.spatial.realign.estimate.eoptions.sep = 4;
	zatlabbatch{1,2}.spm.spatial.realign.estimate.eoptions.fwhm = 5;
	zatlabbatch{1,2}.spm.spatial.realign.estimate.eoptions.rtm = 0; 
	zatlabbatch{1,2}.spm.spatial.realign.estimate.eoptions.interp = 2; 
	zatlabbatch{1,2}.spm.spatial.realign.estimate.eoptions.wrap = [0 0 0]; 
	zatlabbatch{1,2}.spm.spatial.realign.estimate.eoptions.weight = {};
	
    zatlabbatch{1,3}.spm.spatial.realign.write.data = data_a;
	zatlabbatch{1,3}.spm.spatial.realign.write.roptions.which = [2 1]; 
	zatlabbatch{1,3}.spm.spatial.realign.write.roptions.interp = 4; 
	zatlabbatch{1,3}.spm.spatial.realign.write.roptions.wrap = [0 0 0]; 
	zatlabbatch{1,3}.spm.spatial.realign.write.roptions.mask = 1; 
    zatlabbatch{1,3}.spm.spatial.realign.write.roptions.prefix = 'r';

    
    
    	%________________________SEGMENTATION (deriving normalisation parameters) _______________________
run_name = dir(fullfile(func_path,subj{Si},'*RUN1*'));
run1_path = fullfile(run_path,run_name.name)

    mean_realign=[run1_path,'\meana',[run1_files(1).name],',1'];%GE

    zatlabbatch{1,4}.spm.spatial.preproc.data=cellstr(mean_realign);
	zatlabbatch{1,4}.spm.spatial.preproc.output.GM=[0 0 1];
	zatlabbatch{1,4}.spm.spatial.preproc.output.WM=[0 0 1];
	zatlabbatch{1,4}.spm.spatial.preproc.output.CSF=[0 0 0];
	zatlabbatch{1,4}.spm.spatial.preproc.output.biascor=1;
	zatlabbatch{1,4}.spm.spatial.preproc.output.cleanup=0;
	zatlabbatch{1,4}.spm.spatial.preproc.opts.tpm={[spm_dir,'\tpm\grey.nii'];[spm_dir,'\tpm\white.nii'];[spm_dir,'\tpm\csf.nii']};
	
		
	zatlabbatch{1,4}.spm.spatial.preproc.opts.ngaus= [2 2 2 4];
	zatlabbatch{1,4}.spm.spatial.preproc.opts.regtype='mni';
	zatlabbatch{1,4}.spm.spatial.preproc.opts.warpreg=1;
	zatlabbatch{1,4}.spm.spatial.preproc.opts.warpco=25;
	zatlabbatch{1,4}.spm.spatial.preproc.opts.biasreg=0.0001;
	zatlabbatch{1,4}.spm.spatial.preproc.opts.biasfwhm=60;
	zatlabbatch{1,4}.spm.spatial.preproc.opts.samp=3;
	zatlabbatch{1,4}.spm.spatial.preproc.opts.msk={''};
    
    
    %_____________________NORMALIZE: Estimate and Write_____________________

    sour_file = [run1_path,'\meana',[run1_files(1).name],',1'];%GE_shangh

    zatlabbatch{1,5}.spm.spatial.normalise.est.subj.source = cellstr(sour_file);
    zatlabbatch{1,5}.spm.spatial.normalise.est.subj.wtsrc = {};
    
	zatlabbatch{1,5}.spm.spatial.normalise.est.eoptions.template{1,1} = [spm_dir,'\templates\EPI.nii'];
    zatlabbatch{1,5}.spm.spatial.normalise.est.eoptions.weight = {};
    zatlabbatch{1,5}.spm.spatial.normalise.est.eoptions.smosrc = 8;
    zatlabbatch{1,5}.spm.spatial.normalise.est.eoptions.smoref = 0;
    zatlabbatch{1,5}.spm.spatial.normalise.est.eoptions.regtype = 'mni';
    zatlabbatch{1,5}.spm.spatial.normalise.est.eoptions.cutoff = 25;
    zatlabbatch{1,5}.spm.spatial.normalise.est.eoptions.nits = 16;
    zatlabbatch{1,5}.spm.spatial.normalise.est.eoptions.reg = 1;
    
    zatlabbatch{1,6}.spm.spatial.normalise.write.subj.matname = cellstr([sour_file(1,1:end-6),'_seg_sn.mat']);

    zatlabbatch{1,6}.spm.spatial.normalise.write.subj.resample = data_r;
    
    zatlabbatch{1,6}.spm.spatial.normalise.write.roptions.preserve = 0;
    zatlabbatch{1,6}.spm.spatial.normalise.write.roptions.bb = [-78 -112 -50;78 76 85];
    zatlabbatch{1,6}.spm.spatial.normalise.write.roptions.vox = [3 3 3];
    zatlabbatch{1,6}.spm.spatial.normalise.write.roptions.interp = 1;
    zatlabbatch{1,6}.spm.spatial.normalise.write.roptions.wrap = [0 0 0];
    zatlabbatch{1,6}.spm.spatial.normalise.write.roptions.prefix = 'w';
    
	%_____________________SMOOTH_____________________

    zatlabbatch{1,7}.spm.spatial.smooth.data = data_w;
    zatlabbatch{1,7}.spm.spatial.smooth.fwhm = [8 8 8];
	zatlabbatch{1,7}.spm.spatial.smooth.dtype = 0;
    zatlabbatch{1,7}.spm.spatial.smooth.im = 0;
    zatlabbatch{1,7}.spm.spatial.smooth.prefix = 's';

	spm_jobman('run',zatlabbatch)


end