/* 
================================================================================
檔案代號:pjcb_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table pjcb_t
(
pjcbent       number(5)      ,/* 企業編號 */
pjcbcomp       varchar2(10)      ,/* 法人組織 */
pjcbld       varchar2(5)      ,/* 帳套 */
pjcb001       varchar2(1)      ,/* 帳套本位幣順序 */
pjcb002       varchar2(10)      ,/* 成本域(專案編號) */
pjcb003       varchar2(10)      ,/* 成本計算類型 */
pjcb004       number(5,0)      ,/* 年度 */
pjcb005       number(5,0)      ,/* 期別 */
pjcb006       number(20,6)      ,/* 本幣執行預算 */
pjcb007       number(20,6)      ,/* 本幣合約金額 */
pjcb008       varchar2(10)      ,/* 核算幣別 */
pjcb009       number(20,6)      ,/* 現場材料 */
pjcb010       number(20,6)      ,/* 現場包作 */
pjcb011       number(20,6)      ,/* 現場人工 */
pjcb012       number(20,6)      ,/* 現場費用 */
pjcb013       number(20,6)      /* 現場其他 */
);
alter table pjcb_t add constraint pjcb_pk primary key (pjcbent,pjcbld,pjcb001,pjcb002,pjcb003,pjcb004,pjcb005) enable validate;

create unique index pjcb_pk on pjcb_t (pjcbent,pjcbld,pjcb001,pjcb002,pjcb003,pjcb004,pjcb005);

grant select on pjcb_t to tiptop;
grant update on pjcb_t to tiptop;
grant delete on pjcb_t to tiptop;
grant insert on pjcb_t to tiptop;

exit;
