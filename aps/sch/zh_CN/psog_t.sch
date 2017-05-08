/* 
================================================================================
檔案代號:psog_t
檔案名稱:資源每月產能負荷檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psog_t
(
psogent       number(5)      ,/* 企業編號 */
psogsite       varchar2(10)      ,/* 營運據點 */
psog001       varchar2(10)      ,/* APS版本 */
psog002       varchar2(20)      ,/* 執行日期時間 */
psog003       varchar2(20)      ,/* 資源編號 */
psog004       number(5,0)      ,/* 產出年 */
psog005       number(5,0)      ,/* 產出月 */
psog006       number(15,3)      ,/* 可用工時 */
psog007       number(15,3)      ,/* 耗用時間 */
psog008       number(15,3)      /* 調整時間 */
);
alter table psog_t add constraint psog_pk primary key (psogent,psogsite,psog001,psog002,psog003,psog004,psog005) enable validate;

create unique index psog_pk on psog_t (psogent,psogsite,psog001,psog002,psog003,psog004,psog005);

grant select on psog_t to tiptop;
grant update on psog_t to tiptop;
grant delete on psog_t to tiptop;
grant insert on psog_t to tiptop;

exit;
