/* 
================================================================================
檔案代號:psoe_t
檔案名稱:資源每日產能負荷檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psoe_t
(
psoeent       number(5)      ,/* 企業編號 */
psoesite       varchar2(10)      ,/* 營運據點 */
psoe001       varchar2(10)      ,/* APS版本 */
psoe002       varchar2(20)      ,/* 執行日期時間 */
psoe003       varchar2(20)      ,/* 資源編號 */
psoe004       date      ,/* 產出日 */
psoe005       number(15,3)      ,/* 可用工時 */
psoe006       number(15,3)      ,/* 耗用時間 */
psoe007       number(15,3)      /* 調整時間 */
);
alter table psoe_t add constraint psoe_pk primary key (psoeent,psoesite,psoe001,psoe002,psoe003,psoe004) enable validate;

create unique index psoe_pk on psoe_t (psoeent,psoesite,psoe001,psoe002,psoe003,psoe004);

grant select on psoe_t to tiptop;
grant update on psoe_t to tiptop;
grant delete on psoe_t to tiptop;
grant insert on psoe_t to tiptop;

exit;
