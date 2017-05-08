/* 
================================================================================
檔案代號:dzbj_t
檔案名稱:Patch纪录有异动的标准add point清单for客制追单
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzbj_t
(
dzbj001       varchar2(20)      ,/* 来源程序编号 */
dzbj002       number(10)      ,/* 最新识别码使用版次 */
dzbj003       varchar2(60)      ,/* 识别码名称 */
dzbj004       number(10)      ,/* 上次识别码使用版次 */
dzbj005       varchar2(80)      ,/* Patch编号 */
dzbj006       varchar2(1)      ,/* 识别码类型 */
dzbj007       varchar2(20)      ,/* 目标程序编号 */
dzbj008       varchar2(1)      ,/* 使用标示 */
dzbjstus       varchar2(10)      ,/* 状态码 */
dzbjownid       varchar2(20)      ,/* 数据所有者 */
dzbjowndp       varchar2(10)      ,/* 数据所属部门 */
dzbjcrtid       varchar2(20)      ,/* 数据录入者 */
dzbjcrtdp       varchar2(10)      ,/* 数据录入部门 */
dzbjcrtdt       timestamp(0)      ,/* 数据创建日 */
dzbjmodid       varchar2(20)      ,/* 数据更改者 */
dzbjmoddt       timestamp(0)      /* 最近更改日 */
);
alter table dzbj_t add constraint dzbj_pk primary key (dzbj003,dzbj005,dzbj006,dzbj007) enable validate;

create unique index dzbj_pk on dzbj_t (dzbj003,dzbj005,dzbj006,dzbj007);

grant select on dzbj_t to tiptop;
grant update on dzbj_t to tiptop;
grant delete on dzbj_t to tiptop;
grant insert on dzbj_t to tiptop;

exit;
