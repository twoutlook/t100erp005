/* 
================================================================================
檔案代號:psof_t
檔案名稱:資源每週產能負荷檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psof_t
(
psofent       number(5)      ,/* 企業編號 */
psofsite       varchar2(10)      ,/* 營運據點 */
psof001       varchar2(10)      ,/* APS版本 */
psof002       varchar2(20)      ,/* 執行日期時間 */
psof003       varchar2(20)      ,/* 資源編號 */
psof004       number(5,0)      ,/* 產出年 */
psof005       number(5,0)      ,/* 產出週 */
psof006       number(15,3)      ,/* 可用工時 */
psof007       number(15,3)      ,/* 耗用時間 */
psof008       number(15,3)      /* 調整時間 */
);
alter table psof_t add constraint psof_pk primary key (psofent,psofsite,psof001,psof002,psof003,psof004,psof005) enable validate;

create unique index psof_pk on psof_t (psofent,psofsite,psof001,psof002,psof003,psof004,psof005);

grant select on psof_t to tiptop;
grant update on psof_t to tiptop;
grant delete on psof_t to tiptop;
grant insert on psof_t to tiptop;

exit;
