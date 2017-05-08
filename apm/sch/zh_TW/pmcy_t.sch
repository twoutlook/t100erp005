/* 
================================================================================
檔案代號:pmcy_t
檔案名稱:需求滙總分配進度明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table pmcy_t
(
pmcyent       number(5)      ,/* 企業編號 */
pmcysite       varchar2(10)      ,/* 營運據點 */
pmcy001       varchar2(20)      ,/* 需求單號 */
pmcy002       number(10,0)      ,/* 需求項次 */
pmcy003       number(10,0)      ,/* 項次 */
pmcy004       varchar2(10)      ,/* 分配類型 */
pmcy005       varchar2(10)      ,/* 分配組織 */
pmcy006       varchar2(20)      ,/* 分配單號 */
pmcy007       number(10,0)      ,/* 分配項次 */
pmcy008       varchar2(10)      ,/* 分配包裝單位 */
pmcy009       varchar2(10)      ,/* 分配單位 */
pmcy010       number(20,6)      ,/* 分配件數 */
pmcy011       number(20,6)      ,/* 分配件裝數 */
pmcy012       number(20,6)      ,/* 分配數量 */
pmcy013       number(20,6)      ,/* 單價 */
pmcy014       number(20,6)      ,/* 金額 */
pmcy015       varchar2(20)      ,/* 分配人員 */
pmcy016       varchar2(10)      /* 分配部門 */
);
alter table pmcy_t add constraint pmcy_pk primary key (pmcyent,pmcysite,pmcy001,pmcy002,pmcy003) enable validate;

create unique index pmcy_pk on pmcy_t (pmcyent,pmcysite,pmcy001,pmcy002,pmcy003);

grant select on pmcy_t to tiptop;
grant update on pmcy_t to tiptop;
grant delete on pmcy_t to tiptop;
grant insert on pmcy_t to tiptop;

exit;
