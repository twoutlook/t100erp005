/* 
================================================================================
檔案代號:inaq_t
檔案名稱:庫存報廢統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table inaq_t
(
inaqent       number(5)      ,/* 企業編號 */
inaqsite       varchar2(10)      ,/* 營運據點 */
inaq001       varchar2(40)      ,/* 料件編號 */
inaq002       varchar2(256)      ,/* 產品特徵 */
inaq003       varchar2(30)      ,/* 庫存管理特徵 */
inaq004       varchar2(10)      ,/* 待報廢庫位 */
inaq005       varchar2(10)      ,/* 待報廢儲位 */
inaq006       varchar2(30)      ,/* 批號 */
inaq007       varchar2(10)      ,/* 庫存單位 */
inaq008       varchar2(10)      ,/* 報廢原因 */
inaq009       varchar2(20)      ,/* 歸屬單號 */
inaq010       varchar2(10)      ,/* 歸屬部門 */
inaq011       number(20,6)      ,/* 報廢數量 */
inaq012       varchar2(10)      ,/* 參考單位 */
inaq013       number(20,6)      ,/* 參考報廢數量 */
inaq014       date      /* 最近一次報廢日期 */
);
alter table inaq_t add constraint inaq_pk primary key (inaqent,inaqsite,inaq001,inaq002,inaq003,inaq004,inaq005,inaq006,inaq007,inaq008,inaq009,inaq010) enable validate;

create unique index inaq_pk on inaq_t (inaqent,inaqsite,inaq001,inaq002,inaq003,inaq004,inaq005,inaq006,inaq007,inaq008,inaq009,inaq010);

grant select on inaq_t to tiptop;
grant update on inaq_t to tiptop;
grant delete on inaq_t to tiptop;
grant insert on inaq_t to tiptop;

exit;
