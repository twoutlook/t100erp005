/* 
================================================================================
檔案代號:stbr_t
檔案名稱:成本代銷衝減明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbr_t
(
stbrent       number(5)      ,/* 企業編號 */
stbrunit       varchar2(10)      ,/* 應用組織 */
stbrsite       varchar2(10)      ,/* 营运组织 */
stbrdocno       varchar2(20)      ,/* 單據編號 */
stbrseq1       number(10,0)      ,/* 項次1 */
stbrseq2       number(10,0)      ,/* 項次2 */
stbr001       varchar2(10)      ,/* 來源作業 */
stbr002       varchar2(20)      ,/* 來源單號 */
stbr003       number(10,0)      ,/* 來源項次 */
stbr004       varchar2(40)      ,/* 商品編號 */
stbr005       number(20,6)      ,/* 數量 */
stbr006       number(20,6)      ,/* 单价 */
stbr007       number(20,6)      ,/* 金額 */
stbr008       varchar2(10)      ,/* 庫區 */
stbr009       varchar2(10)      ,/* 儲位 */
stbr010       varchar2(30)      /* 批號 */
);
alter table stbr_t add constraint stbr_pk primary key (stbrent,stbrdocno,stbrseq1,stbrseq2) enable validate;

create unique index stbr_pk on stbr_t (stbrent,stbrdocno,stbrseq1,stbrseq2);

grant select on stbr_t to tiptop;
grant update on stbr_t to tiptop;
grant delete on stbr_t to tiptop;
grant insert on stbr_t to tiptop;

exit;
