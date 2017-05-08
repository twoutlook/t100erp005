/* 
================================================================================
檔案代號:pcajl_t
檔案名稱:POS參數值基本資料多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table pcajl_t
(
pcajlent       number(5)      ,/* 企業編號 */
pcajl001       varchar2(60)      ,/* 參數編號 */
pcajl002       varchar2(60)      ,/* 參數值 */
pcajl003       varchar2(6)      ,/* 語言別 */
pcajl004       varchar2(500)      ,/* 參數值說明 */
pcajl005       varchar2(10)      /* 助記碼 */
);
alter table pcajl_t add constraint pcajl_pk primary key (pcajlent,pcajl001,pcajl002,pcajl003) enable validate;

create unique index pcajl_pk on pcajl_t (pcajlent,pcajl001,pcajl002,pcajl003);

grant select on pcajl_t to tiptop;
grant update on pcajl_t to tiptop;
grant delete on pcajl_t to tiptop;
grant insert on pcajl_t to tiptop;

exit;
