/* 
================================================================================
檔案代號:pmbr_t
檔案名稱:供應商評核項目得分檔(製造)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table pmbr_t
(
pmbrent       varchar2(10)      ,/* 企業編號 */
pmbrsite       varchar2(10)      ,/* 營運據點 */
pmbr001       number(5,0)      ,/* 評核年度 */
pmbr002       number(5,0)      ,/* 評核月份 */
pmbr003       varchar2(10)      ,/* 評公式編號 */
pmbr004       varchar2(10)      ,/* 供應商編號 */
pmbr005       varchar2(10)      ,/* 項目類型 */
pmbr006       varchar2(10)      ,/* 項目編號 */
pmbr007       number(15,3)      ,/* 系統得分 */
pmbr008       number(15,3)      ,/* 調整後得分 */
pmbr009       number(5,0)      ,/* 調整次數 */
pmbr010       varchar2(10)      /* 調整理由 */
);
alter table pmbr_t add constraint pmbr_pk primary key (pmbrent,pmbrsite,pmbr001,pmbr002,pmbr003,pmbr004,pmbr005,pmbr006) enable validate;

create unique index pmbr_pk on pmbr_t (pmbrent,pmbrsite,pmbr001,pmbr002,pmbr003,pmbr004,pmbr005,pmbr006);

grant select on pmbr_t to tiptop;
grant update on pmbr_t to tiptop;
grant delete on pmbr_t to tiptop;
grant insert on pmbr_t to tiptop;

exit;
