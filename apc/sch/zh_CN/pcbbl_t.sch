/* 
================================================================================
檔案代號:pcbbl_t
檔案名稱:觸屏方案基本資料表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pcbbl_t
(
pcbblent       number(5)      ,/* 企業編號 */
pcbbl001       varchar2(10)      ,/* 方案編號 */
pcbbl002       varchar2(6)      ,/* 語言別 */
pcbbl003       varchar2(500)      ,/* 說明 */
pcbbl004       varchar2(10)      /* 助記碼 */
);
alter table pcbbl_t add constraint pcbbl_pk primary key (pcbblent,pcbbl001,pcbbl002) enable validate;

create unique index pcbbl_pk on pcbbl_t (pcbblent,pcbbl001,pcbbl002);

grant select on pcbbl_t to tiptop;
grant update on pcbbl_t to tiptop;
grant delete on pcbbl_t to tiptop;
grant insert on pcbbl_t to tiptop;

exit;
