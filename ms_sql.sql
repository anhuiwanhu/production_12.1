insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','12.1.0.01_SP_20170324','12.1.0.01',getdate());
go





update org_right set righthasscope = 1 , rightselectrange = '11111' where rightcode = '07*99*01';
go
update oa_custmenu set MENU_DOMAINID=-1 where MENU_NAME='短信';
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','12.1.0.02_SP_20170508','12.1.0.02',getdate());
go