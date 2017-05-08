/* 
================================================================================
檔案代號:pcafl_t
檔案名稱:POS角色基本資料多語言表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table pcafl_t
(
pcaflent       number(5)      ,/* 企業編號 */
pcafl001       varchar2(10)      ,/* 角色編號 */
pcafl002       varchar2(6)      ,/* 語言別 */
pcafl003       varchar2(500)      ,/* 說明 */
pcafl004       varchar2(10)      /* 助記碼 */
);
alter table pcafl_t add constraint pcafl_pk primary key (pcaflent,pcafl001,pcafl002) enable validate;

create unique index pcafl_pk on pcafl_t (pcaflent,pcafl001,pcafl002);

grant select on pcafl_t to tiptop;
grant update on pcafl_t to tiptop;
grant delete on pcafl_t to tiptop;
grant insert on pcafl_t to tiptop;

exit;
