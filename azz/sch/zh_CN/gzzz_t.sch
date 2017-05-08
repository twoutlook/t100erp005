/* 
================================================================================
檔案代號:gzzz_t
檔案名稱:作業編號設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzz_t
(
gzzzstus       varchar2(10)      ,/* 狀態碼 */
gzzz001       varchar2(20)      ,/* 作業編號 */
gzzz002       varchar2(20)      ,/* 程式編號 */
gzzz003       number(5,0)      ,/* 應用參數組編號 */
gzzz004       varchar2(500)      ,/* 額外參數 */
gzzzownid       varchar2(20)      ,/* 資料所有者 */
gzzzowndp       varchar2(10)      ,/* 資料所屬部門 */
gzzzcrtid       varchar2(20)      ,/* 資料建立者 */
gzzzcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzzzcrtdt       timestamp(0)      ,/* 資料創建日 */
gzzzmodid       varchar2(20)      ,/* 資料修改者 */
gzzzmoddt       timestamp(0)      ,/* 最近修改日 */
gzzz005       varchar2(4)      ,/* 歸屬模組 */
gzzz006       varchar2(20)      ,/* 預設單據性質 */
gzzz007       varchar2(40)      ,/* 佈景編號 */
gzzz008       varchar2(10)      ,/* 色調編號 */
gzzz009       varchar2(10)      ,/* 作業操作模式 */
gzzz010       varchar2(80)      /* 歸屬行業別 */
);
alter table gzzz_t add constraint gzzz_pk primary key (gzzz001) enable validate;

create unique index gzzz_pk on gzzz_t (gzzz001);

grant select on gzzz_t to tiptop;
grant update on gzzz_t to tiptop;
grant delete on gzzz_t to tiptop;
grant insert on gzzz_t to tiptop;

exit;
