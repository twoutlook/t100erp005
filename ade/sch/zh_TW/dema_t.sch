/* 
================================================================================
檔案代號:dema_t
檔案名稱:經銷商日銷售統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dema_t
(
demaent       number(5)      ,/* 企業編號 */
demasite       varchar2(10)      ,/* 營運據點 */
dema001       varchar2(10)      ,/* 客戶經營類型 */
dema002       date      ,/* 統計日期 */
dema003       number(5,0)      ,/* 會計週 */
dema004       number(5,0)      ,/* 會計期 */
dema005       varchar2(10)      ,/* 經銷商編號 */
dema006       varchar2(20)      ,/* 合同編號 */
dema007       varchar2(10)      ,/* 經營方式 */
dema008       varchar2(10)      ,/* 結算類型 */
dema009       varchar2(10)      ,/* 結算方式 */
dema010       varchar2(10)      ,/* 品牌 */
dema011       varchar2(10)      ,/* 稅別編號 */
dema012       varchar2(10)      ,/* 本幣幣別 */
dema013       number(20,6)      ,/* 進價成本金額 */
dema014       number(20,6)      ,/* 銷貨標準售價金額(未稅) */
dema015       number(20,6)      ,/* 銷貨標準售價金額(含稅) */
dema016       number(20,6)      ,/* 銷貨折扣金額 */
dema017       number(20,6)      ,/* 銷貨實收金額(未稅) */
dema018       number(20,6)      ,/* 銷貨實收金額(含稅) */
dema019       number(20,6)      ,/* 毛利額 */
dema020       number(20,6)      ,/* 毛利率 */
dema021       number(20,6)      ,/* 促銷應收金額(未稅) */
dema022       number(20,6)      ,/* 促銷應收金額(含稅) */
dema023       number(20,6)      ,/* 退貨標準售價金額(未稅) */
dema024       number(20,6)      ,/* 退貨標準售價金額(含稅) */
dema025       number(20,6)      ,/* 退貨折扣金額 */
dema026       number(20,6)      ,/* 退貨實退金額(未稅) */
dema027       number(20,6)      ,/* 退貨實退金額(含稅) */
dema028       number(20,6)      ,/* 銷售標準售價淨額(未稅) */
dema029       number(20,6)      ,/* 銷售標準售價淨額(含稅) */
dema030       number(20,6)      ,/* 銷售折扣淨額 */
dema031       number(20,6)      ,/* 銷售實收淨額(未稅) */
dema032       number(20,6)      ,/* 銷售實收淨額(含稅) */
dema033       number(20,6)      ,/* 訂貨標準售價金額(未稅) */
dema034       number(20,6)      ,/* 訂貨標準售價金額(含稅) */
dema035       number(20,6)      ,/* 訂貨折扣金額 */
dema036       number(20,6)      ,/* 訂貨實收金額(未稅) */
dema037       number(20,6)      /* 訂貨實收金額(含稅) */
);
alter table dema_t add constraint dema_pk primary key (demaent,demasite,dema002,dema005,dema006,dema007,dema008,dema009,dema010,dema011) enable validate;

create unique index dema_pk on dema_t (demaent,demasite,dema002,dema005,dema006,dema007,dema008,dema009,dema010,dema011);

grant select on dema_t to tiptop;
grant update on dema_t to tiptop;
grant delete on dema_t to tiptop;
grant insert on dema_t to tiptop;

exit;
