/* 
================================================================================
檔案代號:nmbnl_t
檔案名稱:資金調度項目資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table nmbnl_t
(
nmbnlent       number(5)      ,/* 企業編碼 */
nmbnl001       varchar2(10)      ,/* 收支代碼 */
nmbnl002       varchar2(6)      ,/* 語言別 */
nmbnl003       varchar2(500)      ,/* 說明 */
nmbnl004       varchar2(10)      /* 助記碼 */
);
alter table nmbnl_t add constraint nmbnl_pk primary key (nmbnlent,nmbnl001,nmbnl002) enable validate;

create unique index nmbnl_pk on nmbnl_t (nmbnlent,nmbnl001,nmbnl002);

grant select on nmbnl_t to tiptop;
grant update on nmbnl_t to tiptop;
grant delete on nmbnl_t to tiptop;
grant insert on nmbnl_t to tiptop;

exit;
