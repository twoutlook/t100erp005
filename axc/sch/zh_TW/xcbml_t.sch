/* 
================================================================================
檔案代號:xcbml_t
檔案名稱:成本勾稽核對項目設置檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xcbml_t
(
xcbmlent       number(5)      ,/* 企業編號 */
xcbml001       varchar2(10)      ,/* 核對項目 */
xcbml002       varchar2(6)      ,/* 語言別 */
xcbml003       varchar2(500)      ,/* 說明 */
xcbml004       varchar2(10)      /* 助記碼 */
);
alter table xcbml_t add constraint xcbml_pk primary key (xcbmlent,xcbml001,xcbml002) enable validate;

create unique index xcbml_pk on xcbml_t (xcbmlent,xcbml001,xcbml002);

grant select on xcbml_t to tiptop;
grant update on xcbml_t to tiptop;
grant delete on xcbml_t to tiptop;
grant insert on xcbml_t to tiptop;

exit;
