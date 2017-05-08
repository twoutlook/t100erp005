/* 
================================================================================
檔案代號:rmac_t
檔案名稱:RMA維護單點收檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rmac_t
(
rmacent       number(5)      ,/* 企業編號 */
rmacsite       varchar2(10)      ,/* 營運據點 */
rmacdocno       varchar2(20)      ,/* 單據單號 */
rmacseq       number(10,0)      ,/* 項次 */
rmacseq1       number(10,0)      ,/* 項序 */
rmac001       number(20,6)      ,/* 點收數量 */
rmac002       varchar2(10)      ,/* 庫位 */
rmac003       varchar2(10)      ,/* 儲位 */
rmac004       varchar2(30)      ,/* 批號 */
rmac005       varchar2(256)      ,/* 庫存特徵 */
rmac006       date      ,/* 點收日期 */
rmac007       varchar2(20)      /* 點收人員 */
);
alter table rmac_t add constraint rmac_pk primary key (rmacent,rmacdocno,rmacseq,rmacseq1) enable validate;

create unique index rmac_pk on rmac_t (rmacent,rmacdocno,rmacseq,rmacseq1);

grant select on rmac_t to tiptop;
grant update on rmac_t to tiptop;
grant delete on rmac_t to tiptop;
grant insert on rmac_t to tiptop;

exit;
