/* 
================================================================================
檔案代號:nmaol_t
檔案名稱:網銀交易類型檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table nmaol_t
(
nmaolent       number(5)      ,/* 企業編號 */
nmaol001       varchar2(15)      ,/* 網銀編號 */
nmaol002       varchar2(40)      ,/* 交易類型編號 */
nmaol003       varchar2(6)      ,/* 語言別 */
nmaol004       varchar2(500)      ,/* 說明 */
nmaol005       varchar2(10)      /* 助記碼 */
);
alter table nmaol_t add constraint nmaol_pk primary key (nmaolent,nmaol001,nmaol002,nmaol003) enable validate;

create unique index nmaol_pk on nmaol_t (nmaolent,nmaol001,nmaol002,nmaol003);

grant select on nmaol_t to tiptop;
grant update on nmaol_t to tiptop;
grant delete on nmaol_t to tiptop;
grant insert on nmaol_t to tiptop;

exit;
