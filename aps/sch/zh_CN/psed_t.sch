/* 
================================================================================
檔案代號:psed_t
檔案名稱:APS供給單據供給法則檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psed_t
(
psedent       number(5)      ,/* 企業代碼 */
psedsite       varchar2(10)      ,/* 營運據點 */
psed001       varchar2(10)      ,/* APS版本 */
psed002       varchar2(20)      ,/* 執行日期時間 */
psed003       number(10,0)      ,/* 序號 */
psed004       varchar2(20)      ,/* 單據編號 */
psed005       number(10,0)      ,/* 項次 */
psed006       number(10,0)      ,/* 項序 */
psed007       number(10,0)      ,/* 分批序 */
psed008       varchar2(10)      ,/* 供需類別 */
psed009       varchar2(40)      ,/* 料號 */
psed010       varchar2(256)      ,/* 產品特徵 */
psed011       varchar2(10)      ,/* 庫位 */
psed012       varchar2(10)      ,/* 儲位 */
psed013       varchar2(30)      ,/* 批號 */
psed014       varchar2(30)      /* 庫存管理特徵 */
);
alter table psed_t add constraint psed_pk primary key (psedent,psedsite,psed001,psed002,psed003) enable validate;

create unique index psed_pk on psed_t (psedent,psedsite,psed001,psed002,psed003);

grant select on psed_t to tiptop;
grant update on psed_t to tiptop;
grant delete on psed_t to tiptop;
grant insert on psed_t to tiptop;

exit;
