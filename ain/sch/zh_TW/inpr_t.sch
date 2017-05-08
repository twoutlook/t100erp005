/* 
================================================================================
檔案代號:inpr_t
檔案名稱:料件ABC分類檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table inpr_t
(
inprent       number(5)      ,/* 企業編號 */
inprsite       varchar2(10)      ,/* 營運據點 */
inpr001       varchar2(40)      ,/* 料件編號 */
inpr002       varchar2(10)      ,/* ABC碼 */
inpr003       varchar2(10)      ,/* 變更前ABC碼 */
inpr004       varchar2(1)      ,/* 分類依據 */
inpr005       number(20,6)      ,/* 單價 */
inpr006       number(20,6)      ,/* 金額 */
inpr007       number(20,6)      ,/* 上期結存金額 */
inpr008       number(5,0)      ,/* 計算年度 */
inpr009       number(5,0)      /* 計算期別 */
);
alter table inpr_t add constraint inpr_pk primary key (inprent,inprsite,inpr001) enable validate;

create unique index inpr_pk on inpr_t (inprent,inprsite,inpr001);

grant select on inpr_t to tiptop;
grant update on inpr_t to tiptop;
grant delete on inpr_t to tiptop;
grant insert on inpr_t to tiptop;

exit;
