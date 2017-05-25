insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','12.1.0.01_SP_20170324','12.1.0.01',sysdate);
commit;





update org_right set righthasscope = 1 , rightselectrange = '11111' where rightcode = '07*99*01';
commit;
update oa_custmenu set MENU_DOMAINID=-1 where MENU_NAME='短信';
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','12.1.0.02_SP_20170508','12.1.0.02',sysdate);
commit;






--系统设置：word编辑增加选人范围
alter table org_domain add  evoWordRangeIds clob;
commit;
alter table org_domain add  evoWordRangeNames clob;
commit;

create table ezmobile_wxToken(
  id  NUMBER(20)  not null,
  corpsecret VARCHAR2(500),
  wxToken VARCHAR2(500),	
  tokenTimeStamp VARCHAR2(20),
  constraint PK_ezmobile_wxToken primary key (id)
);
commit;

comment on column ezmobile_wxToken.id is'主键id';
commit;
comment on column ezmobile_wxToken.corpsecret is'企业微信应用对应secret';
commit;
comment on column ezmobile_wxToken.wxToken is'微信生成的token';
commit;
comment on column ezmobile_wxToken.tokenTimeStamp is'token生成的时间戳';
commit;

alter table SYS_CORP_SET_APP add corpsecret varchar2(500) ;
commit;

update OA_CUSTMENU set menu_blone=(select id from OA_CUSTMENU where menucodeset='newMeetingManagement'),
menu_location=(select id from OA_CUSTMENU where menucodeset='newMeetingManagement'),
menu_mantbl_subtbl=(select id from OA_CUSTMENU where menucodeset='newMeetingManagement') where menucodeset='newMeetingManagement';
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','12.1.0.03_SP_20170525','12.1.0.03',sysdate);
commit;