/* 
================================================================================
檔案代號:psps_t
檔案名稱:Firm_EQ(產能鎖定資料)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psps_t
(
pspsent       number(5)      ,/* 企業編號 */
pspssite       varchar2(10)      ,/* 營運據點 */
psps001       varchar2(10)      ,/* APS版本 */
psps002       varchar2(20)      ,/* 執行日期時間 */
psps003       varchar2(80)      ,/* mfg_order_id */
psps004       varchar2(80)      ,/* route_id */
psps005       varchar2(80)      ,/* sequ_num */
psps006       varchar2(80)      ,/* operation_id */
psps007       number(10,0)      ,/* equip_type */
psps008       varchar2(80)      ,/* equip_id */
psps009       number(20,6)      ,/* qty */
psps010       number(10,0)      /* is_scheduled */
);
alter table psps_t add constraint psps_pk primary key (pspsent,pspssite,psps001,psps002,psps003,psps004,psps005,psps006,psps007,psps008) enable validate;

create unique index psps_pk on psps_t (pspsent,pspssite,psps001,psps002,psps003,psps004,psps005,psps006,psps007,psps008);

grant select on psps_t to tiptop;
grant update on psps_t to tiptop;
grant delete on psps_t to tiptop;
grant insert on psps_t to tiptop;

exit;
