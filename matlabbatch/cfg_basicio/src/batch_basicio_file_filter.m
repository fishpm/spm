%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 1184 $)
%-----------------------------------------------------------------------
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.type = 'cfg_files';
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.name = 'Files';
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.tag = 'files';
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.filter = 'any';
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.ufilter = '.*';
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.dir = '';
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.num = double([1 Inf]);
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.check = double([]);
matlabbatch{1}.menu_cfg{1}.menu_entry{1}.conf_files.help = {'Files to be filtered.'};
matlabbatch{2}.menu_cfg{1}.menu_entry{1}.conf_entry.type = 'cfg_entry';
matlabbatch{2}.menu_cfg{1}.menu_entry{1}.conf_entry.name = 'Typ';
matlabbatch{2}.menu_cfg{1}.menu_entry{1}.conf_entry.tag = 'typ';
matlabbatch{2}.menu_cfg{1}.menu_entry{1}.conf_entry.strtype = 's';
matlabbatch{2}.menu_cfg{1}.menu_entry{1}.conf_entry.extras = double([]);
matlabbatch{2}.menu_cfg{1}.menu_entry{1}.conf_entry.num = double([1 Inf]);
matlabbatch{2}.menu_cfg{1}.menu_entry{1}.conf_entry.check = double([]);
matlabbatch{2}.menu_cfg{1}.menu_entry{1}.conf_entry.help = {'Allowed types are (see cfg_getfile): ''any'', ''image'', ''xml'', ''mat'', ''batch'', ''dir'' or a regular expression.'};
matlabbatch{3}.menu_cfg{1}.menu_entry{1}.conf_entry.type = 'cfg_entry';
matlabbatch{3}.menu_cfg{1}.menu_entry{1}.conf_entry.name = 'Filter';
matlabbatch{3}.menu_cfg{1}.menu_entry{1}.conf_entry.tag = 'filter';
matlabbatch{3}.menu_cfg{1}.menu_entry{1}.conf_entry.strtype = 's';
matlabbatch{3}.menu_cfg{1}.menu_entry{1}.conf_entry.extras = double([]);
matlabbatch{3}.menu_cfg{1}.menu_entry{1}.conf_entry.num = double([1 Inf]);
matlabbatch{3}.menu_cfg{1}.menu_entry{1}.conf_entry.check = double([]);
matlabbatch{3}.menu_cfg{1}.menu_entry{1}.conf_entry.help = {'A regular expression to filter files (applied after filtering for ''Typ'').'};
matlabbatch{4}.menu_cfg{1}.menu_entry{1}.conf_entry.type = 'cfg_entry';
matlabbatch{4}.menu_cfg{1}.menu_entry{1}.conf_entry.name = 'Frames';
matlabbatch{4}.menu_cfg{1}.menu_entry{1}.conf_entry.tag = 'frames';
matlabbatch{4}.menu_cfg{1}.menu_entry{1}.conf_entry.strtype = 's';
matlabbatch{4}.menu_cfg{1}.menu_entry{1}.conf_entry.extras = double([]);
matlabbatch{4}.menu_cfg{1}.menu_entry{1}.conf_entry.num = double([0 Inf]);
matlabbatch{4}.menu_cfg{1}.menu_entry{1}.conf_entry.check = double([]);
matlabbatch{4}.menu_cfg{1}.menu_entry{1}.conf_entry.help = {'Number of frames to address in 4D NIfTI images. Ignored if empty.'};
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.type = 'cfg_exbranch';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.name = 'File Filter';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.tag = 'file_filter';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1) = cfg_dep;
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).tname = 'Val Item';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).tgt_exbranch = struct('type', {}, 'subs', {});
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).tgt_input = struct('type', {}, 'subs', {});
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).tgt_spec = {};
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).jtsubs = struct('type', {}, 'subs', {});
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).sname = 'Files (cfg_files)';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(1).type = '.';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(1).subs = 'val';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(2).type = '{}';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(2).subs{1} = double(1);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(3).type = '.';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(3).subs = 'val';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(4).type = '{}';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(4).subs{1} = double(1);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(5).type = '.';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(5).subs = 'val';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(6).type = '{}';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_exbranch(6).subs{1} = double(1);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_output(1).type = '()';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{1}(1).src_output(1).subs{1} = double(1);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1) = cfg_dep;
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).tname = 'Val Item';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).tgt_exbranch = struct('type', {}, 'subs', {});
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).tgt_input = struct('type', {}, 'subs', {});
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).tgt_spec = {};
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).jtsubs = struct('type', {}, 'subs', {});
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).sname = 'Typ (cfg_entry)';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_exbranch(1).type = '.';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_exbranch(1).subs = 'val';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_exbranch(2).type = '{}';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_exbranch(2).subs{1} = double(2);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_exbranch(3).type = '.';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_exbranch(3).subs = 'val';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_exbranch(4).type = '{}';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_exbranch(4).subs{1} = double(1);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_exbranch(5).type = '.';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_exbranch(5).subs = 'val';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_exbranch(6).type = '{}';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_exbranch(6).subs{1} = double(1);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_output(1).type = '()';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{2}(1).src_output(1).subs{1} = double(1);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1) = cfg_dep;
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).tname = 'Val Item';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).tgt_exbranch = struct('type', {}, 'subs', {});
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).tgt_input = struct('type', {}, 'subs', {});
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).tgt_spec = {};
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).jtsubs = struct('type', {}, 'subs', {});
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).sname = 'Filter (cfg_entry)';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_exbranch(1).type = '.';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_exbranch(1).subs = 'val';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_exbranch(2).type = '{}';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_exbranch(2).subs{1} = double(3);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_exbranch(3).type = '.';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_exbranch(3).subs = 'val';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_exbranch(4).type = '{}';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_exbranch(4).subs{1} = double(1);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_exbranch(5).type = '.';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_exbranch(5).subs = 'val';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_exbranch(6).type = '{}';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_exbranch(6).subs{1} = double(1);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_output(1).type = '()';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{3}(1).src_output(1).subs{1} = double(1);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1) = cfg_dep;
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).tname = 'Val Item';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).tgt_exbranch = struct('type', {}, 'subs', {});
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).tgt_input = struct('type', {}, 'subs', {});
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).tgt_spec = {};
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).jtsubs = struct('type', {}, 'subs', {});
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).sname = 'Frames (cfg_entry)';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_exbranch(1).type = '.';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_exbranch(1).subs = 'val';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_exbranch(2).type = '{}';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_exbranch(2).subs{1} = double(4);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_exbranch(3).type = '.';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_exbranch(3).subs = 'val';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_exbranch(4).type = '{}';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_exbranch(4).subs{1} = double(1);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_exbranch(5).type = '.';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_exbranch(5).subs = 'val';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_exbranch(6).type = '{}';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_exbranch(6).subs{1} = double(1);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_output(1).type = '()';
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.val{4}(1).src_output(1).subs{1} = double(1);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.prog = @cfg_run_file_filter;
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.vout = @cfg_vout_file_filter;
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.check = double([]);
matlabbatch{5}.menu_cfg{1}.menu_struct{1}.conf_exbranch.help = {'Filter a list of files using cfg_getfile.'};
