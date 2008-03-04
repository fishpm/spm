%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 1184 $)
%-----------------------------------------------------------------------
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.type = 'cfg_files';
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.name = 'Directory';
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.tag = 'dir';
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.filter = 'dir';
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.ufilter = '.*';
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.dir = '';
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.num = double([1 1]);
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.check = double([]);
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.help = {'New working directory.'};
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.type = 'cfg_exbranch';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.name = 'Change Directory';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.tag = 'cfg_cd';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1) = cfg_dep;
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).tname = 'Val Item';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).tgt_exbranch = struct('type', {}, 'subs', {});
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).tgt_input = struct('type', {}, 'subs', {});
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).tgt_spec = {};
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).jtsubs = struct('type', {}, 'subs', {});
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).sname = 'Directory (cfg_files)';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(1).type = '.';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(1).subs = 'val';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(2).type = '{}';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(2).subs{1} = double(1);
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(3).type = '.';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(3).subs = 'val';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(4).type = '{}';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(4).subs{1} = double(1);
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(5).type = '.';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(5).subs = 'val';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(6).type = '{}';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(6).subs{1} = double(1);
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_output(1).type = '()';
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_output(1).subs{1} = double(1);
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.prog = @cfg_run_cd;
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.vout = double([]);
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.check = double([]);
matlabbatch{2}.menu_cfg{1}.menu_struct{1}.conf_exbranch.help = {'Change working directory.'};
