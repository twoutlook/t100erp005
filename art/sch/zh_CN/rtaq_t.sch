/* 
================================================================================
檔案代號:rtaq_t
檔案名稱:资源协议水电费设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtaq_t
(
rtaqent       number(5)      ,/* 企业编号 */
rtaqunit       varchar2(10)      ,/* 应用组织 */
rtaqsite       varchar2(10)      ,/* 营运据点 */
rtaqdocno       varchar2(20)      ,/* 单据编号 */
rtaqseq       number(10,0)      ,/* 项次 */
rtaqseq1       number(10,0)      ,/* 资源项次 */
rtaq001       varchar2(20)      ,/* 资源协议编号 */
rtaq002       varchar2(10)      ,/* 资源编号 */
rtaq003       varchar2(10)      ,/* 费用编号 */
rtaq004       varchar2(10)      ,/* 费用类型 */
rtaq005       varchar2(10)      ,/* 价款类型 */
rtaq006       varchar2(1)      ,/* 纳入结算单否 */
rtaq007       varchar2(1)      ,/* 票扣否 */
rtaq008       number(20,6)      ,/* 单价 */
rtaq009       number(20,6)      ,/* 优惠度数 */
rtaq010       number(20,6)      ,/* 优惠金额 */
rtaqacti       varchar2(1)      /* 数据有效码 */
);
alter table rtaq_t add constraint rtaq_pk primary key (rtaqent,rtaqdocno,rtaqseq,rtaqseq1) enable validate;

create unique index rtaq_pk on rtaq_t (rtaqent,rtaqdocno,rtaqseq,rtaqseq1);

grant select on rtaq_t to tiptop;
grant update on rtaq_t to tiptop;
grant delete on rtaq_t to tiptop;
grant insert on rtaq_t to tiptop;

exit;
