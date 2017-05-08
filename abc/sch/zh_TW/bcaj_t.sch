/* 
================================================================================
檔案代號:bcaj_t
檔案名稱:供应商送货单单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bcaj_t
(
bcajent       number(5)      ,/* 企业代码 */
bcajsite       varchar2(10)      ,/* 营运据点 */
bcajdocno       varchar2(20)      ,/* 单号 */
bcajseq       number(10,0)      ,/* 项次 */
bcaj000       varchar2(10)      ,/* 供应商编号 */
bcaj001       varchar2(20)      ,/* 采购单号 */
bcaj002       number(10,0)      ,/* 采购项次 */
bcaj003       varchar2(40)      ,/* 料件编号 */
bcaj004       varchar2(255)      ,/* 品名 */
bcaj005       varchar2(255)      ,/* 规格 */
bcaj006       varchar2(10)      ,/* 仓库 */
bcaj007       varchar2(10)      ,/* 单位 */
bcaj008       number(20,6)      ,/* 采购量 */
bcaj009       number(20,6)      ,/* 未交量 */
bcaj010       number(20,6)      ,/* 实发量 */
bcaj011       number(20,6)      ,/* 收货量 */
bcaj012       varchar2(20)      ,/* 发票号 */
bcaj013       number(20,6)      ,/* 箱装量 */
bcaj014       varchar2(10)      ,/* 条码类型 */
bcaj015       varchar2(1)      ,/* 检验否 */
bcajseq1       number(10,0)      ,/* 采购单项序 */
bcajseq2       number(10,0)      /* 采购单分批序 */
);
alter table bcaj_t add constraint bcaj_pk primary key (bcajent,bcajdocno,bcajseq,bcaj000) enable validate;

create unique index bcaj_pk on bcaj_t (bcajent,bcajdocno,bcajseq,bcaj000);

grant select on bcaj_t to tiptop;
grant update on bcaj_t to tiptop;
grant delete on bcaj_t to tiptop;
grant insert on bcaj_t to tiptop;

exit;
