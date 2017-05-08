/* 
================================================================================
檔案代號:dzcbl_t
檔案名稱:開窗設計參數設計表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzcbl_t
(
dzcbl001       varchar2(20)      ,/* 開窗設計識別碼 */
dzcbl002       number(10,0)      ,/* 參數順序 */
dzcbl003       varchar2(6)      ,/* 語言別 */
dzcbl004       varchar2(500)      ,/* 說明 */
dzcbl005       varchar2(10)      /* 助記碼 */
);
alter table dzcbl_t add constraint dzcbl_pk primary key (dzcbl001,dzcbl002,dzcbl003) enable validate;

create unique index dzcbl_pk on dzcbl_t (dzcbl001,dzcbl002,dzcbl003);

grant select on dzcbl_t to tiptop;
grant update on dzcbl_t to tiptop;
grant delete on dzcbl_t to tiptop;
grant insert on dzcbl_t to tiptop;

exit;
