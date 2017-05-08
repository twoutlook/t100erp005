/* 
================================================================================
檔案代號:xcdc_t
檔案名稱:料件庫存成本次要素期異動統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcdc_t
(
xcdcent       number(5)      ,/* 企業編號 */
xcdccomp       varchar2(10)      ,/* 法人組織 */
xcdcld       varchar2(5)      ,/* 賬套 */
xcdc001       varchar2(1)      ,/* 賬套本位幣順序 */
xcdc002       varchar2(30)      ,/* 成本域 */
xcdc003       varchar2(10)      ,/* 成本計算類型 */
xcdc004       number(5,0)      ,/* 年度 */
xcdc005       number(5,0)      ,/* 期別 */
xcdc006       varchar2(40)      ,/* 料號 */
xcdc007       varchar2(256)      ,/* 特性 */
xcdc008       varchar2(30)      ,/* 批號 */
xcdc009       varchar2(10)      ,/* 成本次要素 */
xcdc010       varchar2(10)      ,/* 核算幣別 */
xcdc101       number(20,6)      ,/* 上期結存數量 */
xcdc102       number(20,6)      ,/* 上期結存金額 */
xcdc201       number(20,6)      ,/* 本期採購入庫數量 */
xcdc202       number(20,6)      ,/* 本期採購入庫金額 */
xcdc203       number(20,6)      ,/* 本期委外入庫數量 */
xcdc204       number(20,6)      ,/* 本期委外入庫金額 */
xcdc205       number(20,6)      ,/* 本期工單入庫數量 */
xcdc206       number(20,6)      ,/* 本期工單入庫金額 */
xcdc207       number(20,6)      ,/* 本期重工領出數量 */
xcdc208       number(20,6)      ,/* 本期重工領出金額 */
xcdc209       number(20,6)      ,/* 本期重工入庫數量 */
xcdc210       number(20,6)      ,/* 本期重工入庫金額 */
xcdc211       number(20,6)      ,/* 本期雜項入庫數量 */
xcdc212       number(20,6)      ,/* 本期雜項入庫金額 */
xcdc213       number(20,6)      ,/* 本期調整入庫數量 */
xcdc214       number(20,6)      ,/* 本期調整入庫金額 */
xcdc215       number(20,6)      ,/* 本期銷退入庫數量 */
xcdc216       number(20,6)      ,/* 本期銷退入庫金額 */
xcdc217       number(20,6)      ,/* 本期其他入庫數量 */
xcdc218       number(20,6)      ,/* 本期其他入庫金額 */
xcdc280       number(20,6)      ,/* 本期平均單價 */
xcdc301       number(20,6)      ,/* 本期工單領用數量 */
xcdc302       number(20,6)      ,/* 本期工單領用金額 */
xcdc303       number(20,6)      ,/* 本期銷貨數量 */
xcdc304       number(20,6)      ,/* 本期銷貨成本 */
xcdc305       number(20,6)      ,/* 本期銷退數量 */
xcdc306       number(20,6)      ,/* 本期銷退成本 */
xcdc307       number(20,6)      ,/* 本期銷售費用數量 */
xcdc308       number(20,6)      ,/* 本期銷售費用成本 */
xcdc309       number(20,6)      ,/* 本期雜發數量 */
xcdc310       number(20,6)      ,/* 本期雜發金額 */
xcdc311       number(20,6)      ,/* 本期盤盈虧數量 */
xcdc312       number(20,6)      ,/* 本期盤盈虧金額 */
xcdc313       number(20,6)      ,/* 本期其他出庫數量 */
xcdc314       number(20,6)      ,/* 本期其他出庫金額 */
xcdc401       number(20,6)      ,/* 本期銷貨收入金額 */
xcdc402       number(20,6)      ,/* 本期銷退金額 */
xcdc901       number(20,6)      ,/* 期末結存數量 */
xcdc902       number(20,6)      ,/* 期末結存金額 */
xcdc903       number(20,6)      ,/* 期末結存調整金額 */
xcdctime       timestamp(0)      /* 最近成本計算時間 */
);
alter table xcdc_t add constraint xcdc_pk primary key (xcdcent,xcdcld,xcdc001,xcdc002,xcdc003,xcdc004,xcdc005,xcdc006,xcdc007,xcdc008,xcdc009) enable validate;

create unique index xcdc_pk on xcdc_t (xcdcent,xcdcld,xcdc001,xcdc002,xcdc003,xcdc004,xcdc005,xcdc006,xcdc007,xcdc008,xcdc009);

grant select on xcdc_t to tiptop;
grant update on xcdc_t to tiptop;
grant delete on xcdc_t to tiptop;
grant insert on xcdc_t to tiptop;

exit;
