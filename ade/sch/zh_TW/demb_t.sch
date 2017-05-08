/* 
================================================================================
檔案代號:demb_t
檔案名稱:經銷商單品日銷售統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table demb_t
(
dembent       number(5)      ,/* 企業編號 */
dembsite       varchar2(10)      ,/* 營運據點 */
demb001       varchar2(10)      ,/* 客戶經營類型 */
demb002       date      ,/* 銷售日期 */
demb003       number(5,0)      ,/* 會計週 */
demb004       number(5,0)      ,/* 會計期 */
demb005       varchar2(10)      ,/* 經銷商編號 */
demb006       varchar2(20)      ,/* 合約編號 */
demb007       varchar2(10)      ,/* 經營方式 */
demb008       varchar2(10)      ,/* 結算類型 */
demb009       varchar2(10)      ,/* 結算方式 */
demb010       varchar2(40)      ,/* 商品編號 */
demb011       varchar2(40)      ,/* 商品條碼 */
demb012       varchar2(256)      ,/* 特徵碼 */
demb013       varchar2(10)      ,/* 品牌 */
demb014       varchar2(10)      ,/* 稅別編號 */
demb015       varchar2(10)      ,/* 本幣幣別 */
demb016       varchar2(10)      ,/* 銷售單位 */
demb017       number(20,6)      ,/* 銷售數量 */
demb018       varchar2(10)      ,/* 成本單位 */
demb019       number(20,6)      ,/* 成本單價 */
demb020       number(20,6)      ,/* 進價成本金額 */
demb021       number(20,6)      ,/* 銷貨標準售價金額(未稅) */
demb022       number(20,6)      ,/* 銷貨標準售價金額(含稅) */
demb023       number(20,6)      ,/* 銷貨折扣金額 */
demb024       number(20,6)      ,/* 銷貨實收金額(未稅) */
demb025       number(20,6)      ,/* 銷貨實收金額(含稅) */
demb026       number(20,6)      ,/* 毛利額 */
demb027       number(20,6)      ,/* 毛利率 */
demb028       number(20,6)      ,/* 促銷銷售數量 */
demb029       number(20,6)      ,/* 促銷應收金額(未稅) */
demb030       number(20,6)      ,/* 促銷應收金額(含稅) */
demb031       number(20,6)      ,/* 退貨數量 */
demb032       number(20,6)      ,/* 退貨標準售價金額(未稅) */
demb033       number(20,6)      ,/* 退貨標準售價金額(含稅) */
demb034       number(20,6)      ,/* 退貨折扣金額 */
demb035       number(20,6)      ,/* 退貨實退金額(未稅) */
demb036       number(20,6)      ,/* 退貨實退金額(含稅) */
demb037       number(20,6)      ,/* 銷售標準售價淨額(未稅) */
demb038       number(20,6)      ,/* 銷售標準售價淨額(含稅) */
demb039       number(20,6)      ,/* 銷售折扣淨額 */
demb040       number(20,6)      ,/* 銷售實收淨額(未稅) */
demb041       number(20,6)      ,/* 銷售實收淨額(含稅) */
demb042       number(20,6)      ,/* 訂貨數量 */
demb043       number(20,6)      ,/* 訂貨標準售價金額(未稅) */
demb044       number(20,6)      ,/* 訂貨標準售價金額(含稅) */
demb045       number(20,6)      ,/* 訂貨折扣金額 */
demb046       number(20,6)      ,/* 訂貨實收金額(未稅) */
demb047       number(20,6)      ,/* 訂貨實收金額(含稅) */
demb048       varchar2(10)      /* 網點編號 */
);
alter table demb_t add constraint demb_pk primary key (dembent,dembsite,demb002,demb005,demb006,demb007,demb008,demb009,demb010,demb014,demb016) enable validate;

create unique index demb_pk on demb_t (dembent,dembsite,demb002,demb005,demb006,demb007,demb008,demb009,demb010,demb014,demb016);

grant select on demb_t to tiptop;
grant update on demb_t to tiptop;
grant delete on demb_t to tiptop;
grant insert on demb_t to tiptop;

exit;
