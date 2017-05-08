/* 
================================================================================
檔案代號:debx_t
檔案名稱:門店商品品類會員消費日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table debx_t
(
debxent       number(5)      ,/* 企業編號 */
debxsite       varchar2(10)      ,/* 營運據點 */
debx001       varchar2(10)      ,/* 層級類型 */
debx002       date      ,/* 統計日期 */
debx003       number(5,0)      ,/* 會計週 */
debx004       number(5,0)      ,/* 會計期 */
debx005       varchar2(10)      ,/* 品類編號 */
debx006       varchar2(20)      ,/* no use */
debx007       varchar2(10)      ,/* no use */
debx008       varchar2(10)      ,/* no use */
debx009       varchar2(10)      ,/* no use */
debx010       varchar2(10)      ,/* 會員卡種 */
debx011       varchar2(10)      ,/* 會員等級 */
debx012       number(20,6)      ,/* 銷售數量 */
debx013       number(20,6)      ,/* 銷售成本 */
debx014       number(20,6)      ,/* 進價金額 */
debx015       number(20,6)      ,/* 原價金額 */
debx016       number(20,6)      ,/* 未稅金額 */
debx017       number(20,6)      ,/* 應收金額 */
debx018       number(20,6)      ,/* 毛利 */
debx019       number(20,6)      ,/* 毛利率 */
debx020       number(22,2)      ,/* 會員積分 */
debx021       number(20,6)      ,/* 客單數 */
debx022       number(20,6)      ,/* 抵扣券金額 */
debx023       number(20,6)      ,/* 會員折扣金額 */
debx024       number(20,6)      ,/* 實收金額 */
debx025       number(20,6)      /* 客單價 */
);
alter table debx_t add constraint debx_pk primary key (debxent,debxsite,debx002,debx005,debx010,debx011) enable validate;

create unique index debx_pk on debx_t (debxent,debxsite,debx002,debx005,debx010,debx011);

grant select on debx_t to tiptop;
grant update on debx_t to tiptop;
grant delete on debx_t to tiptop;
grant insert on debx_t to tiptop;

exit;
