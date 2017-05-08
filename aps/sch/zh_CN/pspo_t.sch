/* 
================================================================================
檔案代號:pspo_t
檔案名稱:Mfg_Order_Pegging(存放物料鎖定資料)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspo_t
(
pspoent       number(5)      ,/* 企業編號 */
psposite       varchar2(10)      ,/* 營運據點 */
pspo001       varchar2(10)      ,/* APS版本 */
pspo002       varchar2(20)      ,/* 執行日期時間 */
pspo003       varchar2(80)      ,/* fed_order_id */
pspo004       number(20,6)      ,/* demand_qty */
pspo005       varchar2(80)      ,/* feded_order_id */
pspo006       number(10,0)      ,/* is_demand */
pspo007       number(20,6)      ,/* fed_qty */
pspo008       number(10,0)      ,/* is_stock */
pspo009       number(20,6)      ,/* supply_qty */
pspo010       number(10,0)      ,/* is_lock */
pspo011       varchar2(80)      ,/* part_id */
pspo012       timestamp(0)      ,/* require_time */
pspo013       number(5,0)      ,/* peg_type */
pspo014       varchar2(80)      ,/* super_order_id */
pspo015       number(10,0)      /* 流水碼 */
);
alter table pspo_t add constraint pspo_pk primary key (pspoent,psposite,pspo001,pspo002,pspo015) enable validate;

create unique index pspo_pk on pspo_t (pspoent,psposite,pspo001,pspo002,pspo015);

grant select on pspo_t to tiptop;
grant update on pspo_t to tiptop;
grant delete on pspo_t to tiptop;
grant insert on pspo_t to tiptop;

exit;
