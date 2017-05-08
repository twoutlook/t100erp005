/* 
================================================================================
檔案代號:inav_t
檔案名稱:製造批序號庫存報廢明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table inav_t
(
inavent       number(5)      ,/* 企業代碼 */
inavsite       varchar2(10)      ,/* 營運據點 */
inav001       varchar2(40)      ,/* 料件編號 */
inav002       varchar2(256)      ,/* 產品特徵 */
inav003       varchar2(30)      ,/* 庫存管理特徵 */
inav004       varchar2(10)      ,/* 待報廢庫位 */
inav005       varchar2(10)      ,/* 待報廢儲位 */
inav006       varchar2(30)      ,/* 批號 */
inav007       varchar2(10)      ,/* 庫存單位 */
inav008       varchar2(10)      ,/* 報廢原因 */
inav009       varchar2(20)      ,/* 歸屬單號 */
inav010       varchar2(10)      ,/* 歸屬部門 */
inav011       number(10,0)      ,/* 序號 */
inav012       varchar2(30)      ,/* 製造批號 */
inav013       varchar2(30)      ,/* 製造序號 */
inav014       date      ,/* 製造日期 */
inav015       date      ,/* 有效日期 */
inav016       number(20,6)      ,/* 數量 */
inav017       number(20,6)      /* 已報廢量 */
);
alter table inav_t add constraint inav_pk primary key (inavent,inavsite,inav001,inav002,inav003,inav004,inav005,inav006,inav007,inav008,inav009,inav010,inav011) enable validate;

create unique index inav_pk on inav_t (inavent,inavsite,inav001,inav002,inav003,inav004,inav005,inav006,inav007,inav008,inav009,inav010,inav011);

grant select on inav_t to tiptop;
grant update on inav_t to tiptop;
grant delete on inav_t to tiptop;
grant insert on inav_t to tiptop;

exit;
