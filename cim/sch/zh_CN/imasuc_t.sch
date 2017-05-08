/* 
================================================================================
檔案代號:imasuc_t
檔案名稱:料件批量申请明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imasuc_t
(
imasucent       number(5)      ,/* 企业代码 */
imasuccomp       varchar2(10)      ,/* 法人 */
imasucsite       varchar2(10)      ,/* 营运据点 */
imasucdocno       varchar2(20)      ,/* 单号 */
imasucseq       number(10,0)      ,/* 项次 */
imasucdocdt       date      ,/* 单据日期 */
imasuc000       varchar2(1)      ,/* 申请类别 */
imasuc001       varchar2(40)      ,/* 料件编号 */
imasuc002       varchar2(255)      ,/* 品名 */
imasuc0021       varchar2(255)      ,/* 规格 */
imasuc003       varchar2(10)      ,/* 主分群码 */
imasuc004       varchar2(10)      ,/* 料件类别 */
imasuc005       varchar2(40)      ,/* 特征组别 */
imasuc006       varchar2(10)      ,/* 基础单位 */
imasuc007       varchar2(10)      ,/* 补给策略 */
imasuc008       varchar2(40)      ,/* no use */
imasuc009       varchar2(10)      ,/* 产品分类码 */
imasuc010       varchar2(10)      ,/* 生命周期状态 */
imasuc011       varchar2(40)      ,/* no use */
imasuc012       varchar2(40)      ,/* no use */
imasuc013       varchar2(40)      ,/* 抛转否 */
imasuc014       varchar2(40)      ,/* 产品条码编号 */
imasuc142       varchar2(10)      ,/* 制定组织 */
imasuc015       varchar2(20)      /* aimt300单号 */
);
alter table imasuc_t add constraint imasuc_pk primary key (imasucent,imasucdocno,imasucseq) enable validate;

create unique index imasuc_pk on imasuc_t (imasucent,imasucdocno,imasucseq);

grant select on imasuc_t to tiptop;
grant update on imasuc_t to tiptop;
grant delete on imasuc_t to tiptop;
grant insert on imasuc_t to tiptop;

exit;
