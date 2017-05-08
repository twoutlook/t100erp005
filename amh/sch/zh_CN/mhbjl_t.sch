/* 
================================================================================
檔案代號:mhbjl_t
檔案名稱:圖紙資料表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mhbjl_t
(
mhbjlent       number(5)      ,/* 企業編號 */
mhbjlsite       varchar2(10)      ,/* 營運據點 */
mhbjl003       varchar2(10)      ,/* 圖紙編號 */
mhbjl005       number(5,0)      ,/* 版本 */
mhbjl006       varchar2(6)      ,/* 語言別 */
mhbjl007       varchar2(500)      ,/* 說明 */
mhbjl008       varchar2(10)      /* 助記碼 */
);
alter table mhbjl_t add constraint mhbjl_pk primary key (mhbjlent,mhbjlsite,mhbjl003,mhbjl005,mhbjl006) enable validate;

create unique index mhbjl_pk on mhbjl_t (mhbjlent,mhbjlsite,mhbjl003,mhbjl005,mhbjl006);

grant select on mhbjl_t to tiptop;
grant update on mhbjl_t to tiptop;
grant delete on mhbjl_t to tiptop;
grant insert on mhbjl_t to tiptop;

exit;
