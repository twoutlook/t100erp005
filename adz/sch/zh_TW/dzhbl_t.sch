/* 
================================================================================
檔案代號:dzhbl_t
檔案名稱:資料表欄位檔簽出備份檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzhbl_t
(
dzhbl000       varchar2(40)      ,/* 簽出GUID */
dzhbl001       varchar2(15)      ,/* table代號 */
dzhbl002       varchar2(20)      ,/* 欄位代號 */
dzhbl003       varchar2(6)      ,/* 語言別 */
dzhbl004       varchar2(500)      ,/* 說明 */
dzhbl005       varchar2(10)      /* 助記碼 */
);
alter table dzhbl_t add constraint dzhbl_pk primary key (dzhbl000,dzhbl001,dzhbl002,dzhbl003) enable validate;

create unique index dzhbl_pk on dzhbl_t (dzhbl000,dzhbl001,dzhbl002,dzhbl003);

grant select on dzhbl_t to tiptop;
grant update on dzhbl_t to tiptop;
grant delete on dzhbl_t to tiptop;
grant insert on dzhbl_t to tiptop;

exit;
