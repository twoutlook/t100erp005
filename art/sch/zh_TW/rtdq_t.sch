/* 
================================================================================
檔案代號:rtdq_t
檔案名稱:商品開帳導入資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtdq_t
(
rtdqent       number(5)      ,/* 企業代碼 */
rtdqsite       varchar2(10)      ,/* 營運據點 */
rtdq001       varchar2(10)      ,/* 類別編號 */
rtdq002       varchar2(10)      ,/* 新系統類別編碼 */
rtdq003       varchar2(10)      ,/* 部門 */
rtdq004       varchar2(40)      ,/* 商品編碼 */
rtdq005       varchar2(40)      ,/* 商品條碼 */
rtdq006       varchar2(255)      ,/* 商品名稱 */
rtdq007       varchar2(40)      ,/* 單位 */
rtdq008       varchar2(255)      ,/* 銷售規格 */
rtdq009       varchar2(255)      ,/* 件裝規格 */
rtdq010       varchar2(80)      ,/* 原產地 */
rtdq011       number(20,6)      ,/* 默認進價 */
rtdq012       number(20,6)      ,/* 最後進價 */
rtdq013       varchar2(10)      ,/* 進項稅別 */
rtdq014       varchar2(80)      ,/* 促銷狀態 */
rtdq015       varchar2(80)      ,/* 供應狀態 */
rtdq016       date      ,/* 最後銷售日期 */
rtdq017       date      ,/* 最近進貨日期 */
rtdq018       varchar2(80)      ,/* 門店銷售狀態 */
rtdq019       number(20,6)      ,/* 正常售價 */
rtdq020       number(20,6)      ,/* 現售價 */
rtdq021       varchar2(10)      ,/* 品牌 */
rtdq022       varchar2(255)      ,/* 品牌名稱 */
rtdq023       varchar2(10)      ,/* 供應商編碼 */
rtdq024       varchar2(255)      ,/* 供應商名稱 */
rtdq025       date      ,/* 引入日期 */
rtdq026       date      ,/* 清理日期 */
rtdq027       varchar2(10)      ,/* 銷售稅別 */
rtdq028       varchar2(80)      ,/* 商品類型編碼 */
rtdq029       varchar2(80)      ,/* 庫區編號 */
rtdq030       number(5,0)      ,/* 價格因子 */
rtdq031       varchar2(80)      ,/* 管理權限 */
rtdq032       varchar2(20)      ,/* 任務單號 */
rtdq033       varchar2(20)      ,/* 商品引進單號 */
rtdq034       number(10,0)      ,/* 商品引進項次 */
rtdq035       varchar2(20)      ,/* 合同編號 */
rtdq036       number(20,6)      ,/* 件裝數 */
rtdq037       number(20,6)      ,/* 扣率 */
rtdq038       number(5,0)      ,/* 保質期(天) */
rtdqacti       varchar2(1)      /* 資料有效碼 */
);
alter table rtdq_t add constraint rtdq_pk primary key (rtdqent,rtdqsite,rtdq004,rtdq032) enable validate;

create unique index rtdq_pk on rtdq_t (rtdqent,rtdqsite,rtdq004,rtdq032);

grant select on rtdq_t to tiptop;
grant update on rtdq_t to tiptop;
grant delete on rtdq_t to tiptop;
grant insert on rtdq_t to tiptop;

exit;
