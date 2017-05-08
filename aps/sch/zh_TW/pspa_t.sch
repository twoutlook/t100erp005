/* 
================================================================================
檔案代號:pspa_t
檔案名稱:MRP供需明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspa_t
(
pspaent       number(5)      ,/* 企業編號 */
pspasite       varchar2(10)      ,/* 營運據點 */
pspa001       varchar2(10)      ,/* APS版本 */
pspa002       varchar2(20)      ,/* 執行日期時間 */
pspa003       date      ,/* 實際供需區間 */
pspa004       date      ,/* 供需日期(實際) */
pspa005       varchar2(40)      ,/* 供需類別 */
pspa006       varchar2(40)      ,/* 來源單號 */
pspa007       number(10,0)      ,/* 來源項次 */
pspa008       number(5,0)      ,/* 凍結交期 */
pspa009       number(20,6)      ,/* 數量 */
pspa010       date      ,/* 規劃供需區間 */
pspa011       date      ,/* 供需日期 */
pspa012       varchar2(40)      ,/* 品號 */
pspa013       varchar2(256)      ,/* 品號特徵碼 */
pspa014       varchar2(40)      ,/* 工單品號 */
pspa015       varchar2(256)      ,/* 工單特徵碼 */
pspa016       varchar2(10)      ,/* 流水編號 */
pspa017       varchar2(40)      ,/* 被替代品號 */
pspa018       varchar2(256)      ,/* 被替代特徵碼 */
pspa019       number(5,0)      ,/* 替代型態 */
pspa020       varchar2(10)      ,/* 供需碼 */
pspa021       varchar2(1)      /* 保稅否 */
);
alter table pspa_t add constraint pspa_pk primary key (pspaent,pspasite,pspa001,pspa002,pspa016) enable validate;

create unique index pspa_pk on pspa_t (pspaent,pspasite,pspa001,pspa002,pspa016);

grant select on pspa_t to tiptop;
grant update on pspa_t to tiptop;
grant delete on pspa_t to tiptop;
grant insert on pspa_t to tiptop;

exit;
