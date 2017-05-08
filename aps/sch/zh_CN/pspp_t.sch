/* 
================================================================================
檔案代號:pspp_t
檔案名稱:Inventory_Alocation(存放物料鎖定資料)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspp_t
(
psppent       number(5)      ,/* 企業編號 */
psppsite       varchar2(10)      ,/* 營運據點 */
pspp001       varchar2(10)      ,/* APS版本 */
pspp002       varchar2(20)      ,/* 執行日期時間 */
pspp003       varchar2(80)      ,/* part_id */
pspp004       number(20,6)      ,/* fed_qty */
pspp005       number(20,6)      ,/* demand_qty */
pspp006       number(10,0)      ,/* is_material */
pspp007       varchar2(80)      ,/* order_id */
pspp008       varchar2(80)      ,/* warehouse_id */
pspp009       varchar2(80)      ,/* location */
pspp010       number(10,0)      ,/* is_lock */
pspp011       number(10,0)      ,/* is_demand_order */
pspp012       varchar2(80)      ,/* stock_location */
pspp013       number(5,0)      ,/* peg_type */
pspp014       varchar2(80)      ,/* super_order_id */
pspp015       number(10,0)      /* 流水碼 */
);
alter table pspp_t add constraint pspp_pk primary key (psppent,psppsite,pspp001,pspp002,pspp015) enable validate;

create unique index pspp_pk on pspp_t (psppent,psppsite,pspp001,pspp002,pspp015);

grant select on pspp_t to tiptop;
grant update on pspp_t to tiptop;
grant delete on pspp_t to tiptop;
grant insert on pspp_t to tiptop;

exit;
