/* 
================================================================================
檔案代號:rmab_t
檔案名稱:RMA维护单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rmab_t
(
rmabent       number(5)      ,/* 企业编号 */
rmabsite       varchar2(10)      ,/* 营运据点 */
rmabdocno       varchar2(20)      ,/* 单据单号 */
rmabseq       number(10,0)      ,/* 项次 */
rmab001       varchar2(20)      ,/* 客诉单号 */
rmab002       number(10,0)      ,/* 客诉项次 */
rmab003       varchar2(20)      ,/* 出货单号 */
rmab004       number(10,0)      ,/* 出货项次 */
rmab005       varchar2(20)      ,/* 订单单号 */
rmab006       number(10,0)      ,/* 订单项次 */
rmab007       number(10,0)      ,/* 订单项序 */
rmab008       number(10,0)      ,/* 订单分批序 */
rmab009       varchar2(40)      ,/* 料号 */
rmab010       varchar2(256)      ,/* 产品特征 */
rmab011       varchar2(10)      ,/* 单位 */
rmab012       number(20,6)      ,/* 申请退货数量 */
rmab013       number(20,6)      ,/* 点收数量 */
rmab014       number(20,6)      ,/* 已转维修数量 */
rmab015       number(20,6)      ,/* 已转销退数量 */
rmab016       number(20,6)      ,/* 覆出数量 */
rmab017       varchar2(255)      ,/* 备注 */
rmab018       varchar2(30)      ,/* 序号 */
rmab019       date      ,/* 生产日期 */
rmab020       date      ,/* 有效日期 */
rmab021       date      ,/* 保固日期 */
rmab022       varchar2(1)      /* 保固内 */
);
alter table rmab_t add constraint rmab_pk primary key (rmabent,rmabdocno,rmabseq) enable validate;

create unique index rmab_pk on rmab_t (rmabent,rmabdocno,rmabseq);

grant select on rmab_t to tiptop;
grant update on rmab_t to tiptop;
grant delete on rmab_t to tiptop;
grant insert on rmab_t to tiptop;

exit;
