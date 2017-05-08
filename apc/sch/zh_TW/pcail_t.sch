/* 
================================================================================
檔案代號:pcail_t
檔案名稱:POS參數基本資料多語言表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table pcail_t
(
pcailent       number(5)      ,/* 企業編號 */
pcail001       varchar2(60)      ,/* 參數編號 */
pcail002       varchar2(6)      ,/* 語言別 */
pcail003       varchar2(500)      ,/* 參數說明 */
pcail004       varchar2(10)      /* 助記碼 */
);
alter table pcail_t add constraint pcail_pk primary key (pcailent,pcail001,pcail002) enable validate;

create unique index pcail_pk on pcail_t (pcailent,pcail001,pcail002);

grant select on pcail_t to tiptop;
grant update on pcail_t to tiptop;
grant delete on pcail_t to tiptop;
grant insert on pcail_t to tiptop;

exit;
