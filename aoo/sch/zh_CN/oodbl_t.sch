/* 
================================================================================
檔案代號:oodbl_t
檔案名稱:稅別多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oodbl_t
(
oodblent       number(5)      ,/* 企業編號 */
oodbl001       varchar2(10)      ,/* 交易稅區 */
oodbl002       varchar2(10)      ,/* 稅別代碼 */
oodbl003       varchar2(6)      ,/* 語言別 */
oodbl004       varchar2(500)      /* 說明 */
);
alter table oodbl_t add constraint oodbl_pk primary key (oodblent,oodbl001,oodbl002,oodbl003) enable validate;

create unique index oodbl_pk on oodbl_t (oodblent,oodbl001,oodbl002,oodbl003);

grant select on oodbl_t to tiptop;
grant update on oodbl_t to tiptop;
grant delete on oodbl_t to tiptop;
grant insert on oodbl_t to tiptop;

exit;
