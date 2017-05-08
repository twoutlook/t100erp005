/* 
================================================================================
檔案代號:mmbyl_t
檔案名稱:生效營運組織卡活動規則單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mmbyl_t
(
mmbylent       number(5)      ,/* 企業編號 */
mmbylsite       varchar2(10)      ,/* 營運據點 */
mmbyl001       varchar2(30)      ,/* 活動規則編號 */
mmbyl002       varchar2(10)      ,/* 版本 */
mmbyl003       varchar2(6)      ,/* 語言別 */
mmbyl004       varchar2(500)      ,/* 說明 */
mmbyl005       varchar2(10)      /* 助記碼 */
);
alter table mmbyl_t add constraint mmbyl_pk primary key (mmbylent,mmbylsite,mmbyl001,mmbyl002,mmbyl003) enable validate;

create unique index mmbyl_pk on mmbyl_t (mmbylent,mmbylsite,mmbyl001,mmbyl002,mmbyl003);

grant select on mmbyl_t to tiptop;
grant update on mmbyl_t to tiptop;
grant delete on mmbyl_t to tiptop;
grant insert on mmbyl_t to tiptop;

exit;
