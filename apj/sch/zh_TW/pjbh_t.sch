/* 
================================================================================
檔案代號:pjbh_t
檔案名稱:项目WBS进度档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbh_t
(
pjbhent       number(5)      ,/* 企业编号 */
pjbh001       varchar2(20)      ,/* 项目编号 */
pjbh002       varchar2(30)      ,/* 本阶WBS */
pjbh003       number(10,0)      ,/* 项次 */
pjbh004       number(15,3)      ,/* 完成天数 */
pjbh005       number(15,3)      ,/* 完成时数 */
pjbh006       number(20,6)      ,/* 完成百分比 */
pjbh007       date      ,/* 进度更新日期 */
pjbh008       varchar2(20)      ,/* 进度更新人员 */
pjbh009       varchar2(4000)      ,/* 备注 */
pjbhud001       varchar2(40)      ,/* 实际开始日期 */
pjbhud002       varchar2(40)      ,/* 实际结束日期 */
pjbhud003       varchar2(40)      ,/* 自定义字段(文本)003 */
pjbhud004       varchar2(40)      ,/* 自定义字段(文本)004 */
pjbhud005       varchar2(40)      ,/* 自定义字段(文本)005 */
pjbhud006       varchar2(40)      ,/* 自定义字段(文本)006 */
pjbhud007       varchar2(40)      ,/* 自定义字段(文本)007 */
pjbhud008       varchar2(40)      ,/* 自定义字段(文本)008 */
pjbhud009       varchar2(40)      ,/* 自定义字段(文本)009 */
pjbhud010       varchar2(40)      ,/* 自定义字段(文本)010 */
pjbhud011       number(20,6)      ,/* 自定义字段(数字)011 */
pjbhud012       number(20,6)      ,/* 自定义字段(数字)012 */
pjbhud013       number(20,6)      ,/* 自定义字段(数字)013 */
pjbhud014       number(20,6)      ,/* 自定义字段(数字)014 */
pjbhud015       number(20,6)      ,/* 自定义字段(数字)015 */
pjbhud016       number(20,6)      ,/* 自定义字段(数字)016 */
pjbhud017       number(20,6)      ,/* 自定义字段(数字)017 */
pjbhud018       number(20,6)      ,/* 自定义字段(数字)018 */
pjbhud019       number(20,6)      ,/* 自定义字段(数字)019 */
pjbhud020       number(20,6)      ,/* 自定义字段(数字)020 */
pjbhud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
pjbhud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
pjbhud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
pjbhud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
pjbhud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
pjbhud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
pjbhud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
pjbhud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
pjbhud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
pjbhud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table pjbh_t add constraint pjbh_pk primary key (pjbhent,pjbh001,pjbh002,pjbh003) enable validate;

create unique index pjbh_pk on pjbh_t (pjbhent,pjbh001,pjbh002,pjbh003);

grant select on pjbh_t to tiptop;
grant update on pjbh_t to tiptop;
grant delete on pjbh_t to tiptop;
grant insert on pjbh_t to tiptop;

exit;
