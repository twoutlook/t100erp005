/* 
================================================================================
檔案代號:glen_t
檔案名稱:合併現金流量表直接法結果上傳檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table glen_t
(
glenent       number(5)      ,/* 企業編號 */
glenld       varchar2(5)      ,/* 合併帳套 */
glen001       varchar2(10)      ,/* 上層公司 */
glen002       varchar2(5)      ,/* 帳套 */
glen003       number(5,0)      ,/* 年度 */
glen004       number(5,0)      ,/* 期別 */
glen005       varchar2(10)      ,/* 現金變動碼 */
glen006       varchar2(10)      ,/* 幣別(記帳幣) */
glen007       number(20,6)      ,/* 金額(記帳幣) */
glen008       varchar2(10)      ,/* 幣別(功能幣) */
glen009       number(20,6)      ,/* 金額(功能幣) */
glen010       varchar2(10)      ,/* 幣別(報告幣) */
glen011       number(20,6)      /* 金額(報告幣) */
);
alter table glen_t add constraint glen_pk primary key (glenent,glenld,glen001,glen002,glen003,glen004,glen005) enable validate;

create unique index glen_pk on glen_t (glenent,glenld,glen001,glen002,glen003,glen004,glen005);

grant select on glen_t to tiptop;
grant update on glen_t to tiptop;
grant delete on glen_t to tiptop;
grant insert on glen_t to tiptop;

exit;
