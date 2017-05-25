insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','12.1.0.01_SP_20170324','12.1.0.01',getdate());
go





update org_right set righthasscope = 1 , rightselectrange = '11111' where rightcode = '07*99*01';
go
update oa_custmenu set MENU_DOMAINID=-1 where MENU_NAME='短信';
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','12.1.0.02_SP_20170508','12.1.0.02',getdate());
go






--系统设置：word编辑增加选人范围
alter table org_domain add  evoWordRangeIds text;
go
alter table org_domain add  evoWordRangeNames text;
go
alter table SYS_CORP_SET_APP add corpsecret NVARCHAR(500);
go

CREATE table EZOFFICE.ezmobile_wxToken(
    id              numeric(20,0) IDENTITY NOT NULL,
    corpsecret          NVARCHAR(500),
    wxToken           NVARCHAR(500),  
    tokenTimeStamp       NVARCHAR(20)  
);
go
update OA_CUSTMENU set menu_blone=(select id from OA_CUSTMENU where menucodeset='newMeetingManagement'),
menu_location=(select id from OA_CUSTMENU where menucodeset='newMeetingManagement'),
menu_mantbl_subtbl=(select id from OA_CUSTMENU where menucodeset='newMeetingManagement') where menucodeset='newMeetingManagement'
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','12.1.0.03_SP_20170525','12.1.0.03',getdate());
go