/* 
================================================================================
檔案代號:xrgh_t
檔案名稱:销售信用状更改历程档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xrgh_t
(
xrghent       number(5)      ,/* 企业编号 */
xrghcomp       varchar2(10)      ,/* 法人 */
xrghdocno       varchar2(20)      ,/* 申请单号 */
xrghseq       number(10,0)      ,/* 项次 */
xrgh001       number(10,0)      ,/* 变更序 */
xrgh002       varchar2(20)      ,/* 变更字段 */
xrgh003       varchar2(10)      ,/* 变更类型 */
xrgh004       varchar2(255)      ,/* 变更前内容 */
xrgh005       varchar2(255)      ,/* 变更后内容 */
xrgh006       varchar2(80)      ,/* 最后变更时间 */
xrgh007       varchar2(500)      ,/* 字段说明SQL */
xrghstus       varchar2(10)      /* 状态码 */
);
alter table xrgh_t add constraint xrgh_pk primary key (xrghent,xrghcomp,xrghdocno,xrghseq,xrgh001,xrgh002) enable validate;

create unique index xrgh_pk on xrgh_t (xrghent,xrghcomp,xrghdocno,xrghseq,xrgh001,xrgh002);

grant select on xrgh_t to tiptop;
grant update on xrgh_t to tiptop;
grant delete on xrgh_t to tiptop;
grant insert on xrgh_t to tiptop;

exit;
