/* 
================================================================================
檔案代號:sffeuc_t
檔案名稱:报工单刀具明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sffeuc_t
(
sffeucent       number(5)      ,/* 企业编号 */
sffeucsite       varchar2(10)      ,/* 营运据点 */
sffeucdocno       varchar2(20)      ,/* 报工单号 */
sffeucseq       number(10,0)      ,/* 项次 */
sffeuc001       varchar2(20)      ,/* 刀具编号 */
sffeuc002       varchar2(40)      ,/* no use */
sffeuc003       varchar2(40)      ,/* no use */
sffeuc004       varchar2(40)      ,/* no use */
sffeuc005       varchar2(40)      ,/* no use */
sffeuc006       varchar2(40)      /* no use */
);
alter table sffeuc_t add constraint sffeuc_pk primary key (sffeucent,sffeucdocno,sffeucseq,sffeuc001) enable validate;

create unique index sffeuc_pk on sffeuc_t (sffeucent,sffeucdocno,sffeucseq,sffeuc001);

grant select on sffeuc_t to tiptop;
grant update on sffeuc_t to tiptop;
grant delete on sffeuc_t to tiptop;
grant insert on sffeuc_t to tiptop;

exit;
