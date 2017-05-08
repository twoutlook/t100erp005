/* 
================================================================================
檔案代號:mmbtl_t
檔案名稱:卡活動規則單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mmbtl_t
(
mmbtlent       number(5)      ,/* 企業編號 */
mmbtl001       varchar2(30)      ,/* 活動規則編號 */
mmbtl002       varchar2(6)      ,/* 語言別 */
mmbtl003       varchar2(500)      ,/* 說明 */
mmbtl004       varchar2(10)      /* 助記碼 */
);
alter table mmbtl_t add constraint mmbtl_pk primary key (mmbtlent,mmbtl001,mmbtl002) enable validate;

create unique index mmbtl_pk on mmbtl_t (mmbtlent,mmbtl001,mmbtl002);

grant select on mmbtl_t to tiptop;
grant update on mmbtl_t to tiptop;
grant delete on mmbtl_t to tiptop;
grant insert on mmbtl_t to tiptop;

exit;
