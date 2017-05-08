/* 
================================================================================
檔案代號:rtbbl_t
檔案名稱:庫區異動單單身檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table rtbbl_t
(
rtbblent       number(5)      ,/* 企業編號 */
rtbbldocno       varchar2(20)      ,/* 單據編號 */
rtbblseqno       number(10,0)      ,/* 項次 */
rtbbl001       varchar2(6)      ,/* 語言別 */
rtbbl002       varchar2(500)      ,/* 說明 */
rtbbl003       varchar2(10)      /* 助記碼 */
);
alter table rtbbl_t add constraint rtbbl_pk primary key (rtbblent,rtbbldocno,rtbblseqno,rtbbl001) enable validate;

create unique index rtbbl_pk on rtbbl_t (rtbblent,rtbbldocno,rtbblseqno,rtbbl001);

grant select on rtbbl_t to tiptop;
grant update on rtbbl_t to tiptop;
grant delete on rtbbl_t to tiptop;
grant insert on rtbbl_t to tiptop;

exit;
