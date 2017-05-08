/* 
================================================================================
檔案代號:glafl_t
檔案名稱:自由核算項資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glafl_t
(
glaflent       number(5)      ,/* 企業編號 */
glafl001       varchar2(10)      ,/* 自由核算項類型編號 */
glafl002       varchar2(30)      ,/* 核算項值 */
glafl003       varchar2(6)      ,/* 語言別 */
glafl004       varchar2(500)      ,/* 說明 */
glafl005       varchar2(10)      /* 助記碼 */
);
alter table glafl_t add constraint glafl_pk primary key (glaflent,glafl001,glafl002,glafl003) enable validate;

create unique index glafl_pk on glafl_t (glaflent,glafl001,glafl002,glafl003);

grant select on glafl_t to tiptop;
grant update on glafl_t to tiptop;
grant delete on glafl_t to tiptop;
grant insert on glafl_t to tiptop;

exit;
