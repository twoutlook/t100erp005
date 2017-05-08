/* 
================================================================================
檔案代號:xcbz_t
檔案名稱:料件庫存量按帳套期統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcbz_t
(
xcbzent       number(5)      ,/* 企業編號 */
xcbzcomp       varchar2(10)      ,/* 法人組織 */
xcbzld       varchar2(5)      ,/* 帳套 */
xcbzsite       varchar2(10)      ,/* 營運據點 */
xcbz001       number(5,0)      ,/* 年度 */
xcbz002       number(5,0)      ,/* 期別 */
xcbz003       varchar2(40)      ,/* 料件編號 */
xcbz004       varchar2(256)      ,/* 特性 */
xcbz005       varchar2(30)      ,/* 庫存管理特徵 */
xcbz006       varchar2(10)      ,/* 倉庫編碼 */
xcbz007       varchar2(10)      ,/* 儲位編號 */
xcbz008       varchar2(30)      ,/* 批號 */
xcbz009       varchar2(10)      ,/* 單位 */
xcbz101       number(20,6)      ,/* 上期結存數量 */
xcbz201       number(20,6)      ,/* 本期採購入庫數量 */
xcbz202       number(20,6)      ,/* 本期委外入庫數量 */
xcbz203       number(20,6)      ,/* 本期工單入庫數量 */
xcbz204       number(20,6)      ,/* 本期重工領出數量 */
xcbz205       number(20,6)      ,/* 本期重工入庫數量 */
xcbz206       number(20,6)      ,/* 本期雜項入庫數量 */
xcbz207       number(20,6)      ,/* 本期調整入庫數量 */
xcbz208       number(20,6)      ,/* 本期銷退入庫數量 */
xcbz209       number(20,6)      ,/* 本期其他入庫數量 */
xcbz301       number(20,6)      ,/* 本期工單領用數量 */
xcbz302       number(20,6)      ,/* 本期銷貨數量 */
xcbz303       number(20,6)      ,/* 本期銷退數量 */
xcbz304       number(20,6)      ,/* 本期雜發數量 */
xcbz305       number(20,6)      ,/* 本期盤盈虧數量 */
xcbz306       number(20,6)      ,/* 本期其他出庫數量 */
xcbz901       number(20,6)      /* 期末結存數量 */
);
alter table xcbz_t add constraint xcbz_pk primary key (xcbzent,xcbzld,xcbzsite,xcbz001,xcbz002,xcbz003,xcbz004,xcbz005,xcbz006,xcbz007,xcbz008,xcbz009) enable validate;

create unique index xcbz_pk on xcbz_t (xcbzent,xcbzld,xcbzsite,xcbz001,xcbz002,xcbz003,xcbz004,xcbz005,xcbz006,xcbz007,xcbz008,xcbz009);

grant select on xcbz_t to tiptop;
grant update on xcbz_t to tiptop;
grant delete on xcbz_t to tiptop;
grant insert on xcbz_t to tiptop;

exit;
