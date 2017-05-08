/* 
================================================================================
檔案代號:mhabl_t
檔案名稱:樓層基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mhabl_t
(
mhablent       number(5)      ,/* 企業編號 */
mhabl001       varchar2(10)      ,/* 樓棟編號 */
mhabl002       varchar2(10)      ,/* 樓層編號 */
mhabl003       varchar2(6)      ,/* 語言別 */
mhabl004       varchar2(500)      ,/* 說明 */
mhabl005       varchar2(10)      /* 助記碼 */
);
alter table mhabl_t add constraint mhabl_pk primary key (mhablent,mhabl001,mhabl002,mhabl003) enable validate;

create unique index mhabl_pk on mhabl_t (mhablent,mhabl001,mhabl002,mhabl003);

grant select on mhabl_t to tiptop;
grant update on mhabl_t to tiptop;
grant delete on mhabl_t to tiptop;
grant insert on mhabl_t to tiptop;

exit;
