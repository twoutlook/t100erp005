/* 
================================================================================
檔案代號:xcdi_t
檔案名稱:拆件在製成本次要素期異動統計當
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcdi_t
(
xcdient       number(5)      ,/* 企業編號 */
xcdicomp       varchar2(10)      ,/* 法人組織 */
xcdild       varchar2(5)      ,/* 賬套 */
xcdi001       varchar2(1)      ,/* 賬套本位幣順序 */
xcdi002       varchar2(30)      ,/* 成本域 */
xcdi003       varchar2(10)      ,/* 成本計算類型 */
xcdi004       number(5,0)      ,/* 年度 */
xcdi005       number(5,0)      ,/* 期別 */
xcdi006       varchar2(20)      ,/* 拆件工單編號 */
xcdi007       varchar2(40)      ,/* 元件料號 */
xcdi008       varchar2(256)      ,/* 特性 */
xcdi009       varchar2(30)      ,/* 批次 */
xcdi010       varchar2(10)      ,/* 成本次要素 */
xcdi020       varchar2(10)      ,/* 核算幣別 */
xcdi101       number(20,6)      ,/* 上期結存數量 */
xcdi102       number(20,6)      ,/* 上期結存金額 */
xcdi201       number(20,6)      ,/* 本期投入數量 */
xcdi202       number(20,6)      ,/* 本期本階投入金額 */
xcdi301       number(20,6)      ,/* 本期轉出數量 */
xcdi302       number(20,6)      ,/* 本期轉出金額 */
xcdi303       number(20,6)      ,/* 差異轉出數量 */
xcdi304       number(20,6)      ,/* 差異轉出金額 */
xcdi901       number(20,6)      ,/* 期末結存數量 */
xcdi902       number(20,6)      ,/* 期末結存金額 */
xcditime       timestamp(0)      /* 最近成本計算時間 */
);
alter table xcdi_t add constraint xcdi_pk primary key (xcdient,xcdild,xcdi001,xcdi002,xcdi003,xcdi004,xcdi005,xcdi006,xcdi007,xcdi008,xcdi009,xcdi010) enable validate;

create unique index xcdi_pk on xcdi_t (xcdient,xcdild,xcdi001,xcdi002,xcdi003,xcdi004,xcdi005,xcdi006,xcdi007,xcdi008,xcdi009,xcdi010);

grant select on xcdi_t to tiptop;
grant update on xcdi_t to tiptop;
grant delete on xcdi_t to tiptop;
grant insert on xcdi_t to tiptop;

exit;
