/* 
================================================================================
檔案代號:inbl_t
檔案名稱:庫存有效日期變更明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inbl_t
(
inblent       number(5)      ,/* 企業編號 */
inblsite       varchar2(10)      ,/* 營運據點 */
inbldocno       varchar2(20)      ,/* 單據編號 */
inblseq       number(10,0)      ,/* 項次 */
inbl001       varchar2(40)      ,/* 料件編號 */
inbl002       varchar2(256)      ,/* 產品特徵 */
inbl003       varchar2(30)      ,/* 批號 */
inbl004       varchar2(30)      ,/* 製造批號 */
inbl005       varchar2(30)      ,/* 製造序號 */
inbl006       date      ,/* 原始有效日期 */
inbl007       date      ,/* 變更後有效日期 */
inbl008       varchar2(10)      ,/* 原因碼 */
inbl009       varchar2(255)      /* 備註 */
);
alter table inbl_t add constraint inbl_pk primary key (inblent,inbldocno,inblseq) enable validate;

create unique index inbl_pk on inbl_t (inblent,inbldocno,inblseq);

grant select on inbl_t to tiptop;
grant update on inbl_t to tiptop;
grant delete on inbl_t to tiptop;
grant insert on inbl_t to tiptop;

exit;
