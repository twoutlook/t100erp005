/* 
================================================================================
檔案代號:rtam_t
檔案名稱:门店资源协议维护单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtam_t
(
rtament       number(5)      ,/* 企业编号 */
rtamunit       varchar2(10)      ,/* 应用组织 */
rtamsite       varchar2(10)      ,/* 所属组织 */
rtamdocno       varchar2(20)      ,/* 单据编号 */
rtamdocdt       date      ,/* 单据日期 */
rtamstus       varchar2(10)      ,/* 状态码 */
rtam000       varchar2(20)      ,/* 作业方式 */
rtam001       varchar2(20)      ,/* 资源协议编号 */
rtam002       number(5,0)      ,/* 版本 */
rtam003       varchar2(20)      ,/* 促销活动主题 */
rtam004       varchar2(20)      ,/* 谈判人员 */
rtam005       varchar2(10)      ,/* 谈判组织 */
rtam006       varchar2(255)      ,/* 备注 */
rtamownid       varchar2(20)      ,/* 资料所有者 */
rtamowndp       varchar2(10)      ,/* 资料所有部门 */
rtamcrtid       varchar2(20)      ,/* 资料录入者 */
rtamcrtdp       varchar2(10)      ,/* 资料录入部门 */
rtamcrtdt       timestamp(0)      ,/* 资料创建日 */
rtammodid       varchar2(20)      ,/* 资料更改者 */
rtammoddt       timestamp(0)      ,/* 最近更改日 */
rtamcnfid       varchar2(20)      ,/* 资料审核者 */
rtamcnfdt       timestamp(0)      ,/* 数据审核日 */
rtam007       varchar2(10)      /* 资源类型 */
);
alter table rtam_t add constraint rtam_pk primary key (rtament,rtamdocno) enable validate;

create unique index rtam_pk on rtam_t (rtament,rtamdocno);

grant select on rtam_t to tiptop;
grant update on rtam_t to tiptop;
grant delete on rtam_t to tiptop;
grant insert on rtam_t to tiptop;

exit;
