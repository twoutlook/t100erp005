/* 
================================================================================
檔案代號:mhbbl_t
檔案名稱:場地申請明細檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mhbbl_t
(
mhbblent       number(5)      ,/* 企業編號 */
mhbbldocno       varchar2(20)      ,/* 單據編號 */
mhbbl001       varchar2(20)      ,/* 場地編號 */
mhbbl002       varchar2(6)      ,/* 語言別 */
mhbbl003       varchar2(500)      ,/* 說明 */
mhbbl004       varchar2(10)      /* 助記碼 */
);
alter table mhbbl_t add constraint mhbbl_pk primary key (mhbblent,mhbbldocno,mhbbl001,mhbbl002) enable validate;

create unique index mhbbl_pk on mhbbl_t (mhbblent,mhbbldocno,mhbbl001,mhbbl002);

grant select on mhbbl_t to tiptop;
grant update on mhbbl_t to tiptop;
grant delete on mhbbl_t to tiptop;
grant insert on mhbbl_t to tiptop;

exit;
