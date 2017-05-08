/* 
================================================================================
檔案代號:psoy_t
檔案名稱:製程配置關係檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psoy_t
(
psoyent       number(5)      ,/* 企業編號 */
psoysite       varchar2(10)      ,/* 營運據點 */
psoy001       varchar2(10)      ,/* APS版本 */
psoy002       varchar2(20)      ,/* 執行日期時間 */
psoy003       varchar2(40)      ,/* 上階工單單號 */
psoy004       varchar2(10)      ,/* 上階製程式號 */
psoy005       number(5,0)      ,/* 上階製程資源型態 */
psoy006       number(5,0)      ,/* 上階製程是否外包 */
psoy007       varchar2(20)      ,/* 上階製程資源編號 */
psoy008       varchar2(40)      ,/* 下階工單單號 */
psoy009       varchar2(10)      ,/* 下階製程式號 */
psoy010       number(5,0)      ,/* 下階製程資源型態 */
psoy011       number(5,0)      ,/* 下階製程外包 */
psoy012       varchar2(20)      ,/* 下階製程資源編號 */
psoy013       varchar2(40)      ,/* 來源訂單 */
psoy018       number(10,0)      /* 流水編號 */
);
alter table psoy_t add constraint psoy_pk primary key (psoyent,psoysite,psoy001,psoy002,psoy018) enable validate;

create unique index psoy_pk on psoy_t (psoyent,psoysite,psoy001,psoy002,psoy018);

grant select on psoy_t to tiptop;
grant update on psoy_t to tiptop;
grant delete on psoy_t to tiptop;
grant insert on psoy_t to tiptop;

exit;
