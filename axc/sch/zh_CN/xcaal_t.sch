/* 
================================================================================
檔案代號:xcaal_t
檔案名稱:標準成本分類檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xcaal_t
(
xcaalent       number(5)      ,/* 企業編號 */
xcaal001       varchar2(10)      ,/* 標準成本分類 */
xcaal002       varchar2(6)      ,/* 語言別 */
xcaal003       varchar2(500)      ,/* 說明 */
xcaal004       varchar2(10)      /* 助記碼 */
);
alter table xcaal_t add constraint xcaal_pk primary key (xcaalent,xcaal001,xcaal002) enable validate;

create unique index xcaal_pk on xcaal_t (xcaalent,xcaal001,xcaal002);

grant select on xcaal_t to tiptop;
grant update on xcaal_t to tiptop;
grant delete on xcaal_t to tiptop;
grant insert on xcaal_t to tiptop;

exit;
