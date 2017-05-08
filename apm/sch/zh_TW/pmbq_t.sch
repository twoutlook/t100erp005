/* 
================================================================================
檔案代號:pmbq_t
檔案名稱:供應商評核綜合總得分檔(製造)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table pmbq_t
(
pmbqent       varchar2(10)      ,/* 企業編號 */
pmbqsite       varchar2(10)      ,/* 營運據點 */
pmbq001       number(5,0)      ,/* 評核年度 */
pmbq002       number(5,0)      ,/* 評核月份 */
pmbq003       varchar2(10)      ,/* 評公式編號 */
pmbq004       varchar2(10)      ,/* 供應商編號 */
pmbq005       number(15,3)      ,/* 系統得分 */
pmbq006       number(15,3)      ,/* 調整後得分 */
pmbq007       varchar2(10)      ,/* 評核等級 */
pmbq008       varchar2(10)      ,/* 建議處理方案 */
pmbq009       number(5,0)      ,/* 調整次數 */
pmbq010       varchar2(20)      ,/* 調整人員 */
pmbq011       timestamp(0)      ,/* 調整日期時間 */
pmbq012       varchar2(10)      /* 調整理由 */
);
alter table pmbq_t add constraint pmbq_pk primary key (pmbqent,pmbqsite,pmbq001,pmbq002,pmbq003,pmbq004) enable validate;

create unique index pmbq_pk on pmbq_t (pmbqent,pmbqsite,pmbq001,pmbq002,pmbq003,pmbq004);

grant select on pmbq_t to tiptop;
grant update on pmbq_t to tiptop;
grant delete on pmbq_t to tiptop;
grant insert on pmbq_t to tiptop;

exit;
