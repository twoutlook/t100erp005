/* 
================================================================================
檔案代號:xcdf_t
檔案名稱:在制元件工藝成本次要素期異動統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcdf_t
(
xcdfent       number(5)      ,/* 企業編號 */
xcdfcomp       varchar2(10)      ,/* 法人組織 */
xcdfld       varchar2(5)      ,/* 賬套 */
xcdf001       varchar2(1)      ,/* 賬套本位幣順序 */
xcdf002       varchar2(30)      ,/* 成本域 */
xcdf003       varchar2(10)      ,/* 成本計算類型 */
xcdf004       number(5,0)      ,/* 年度 */
xcdf005       number(5,0)      ,/* 期別 */
xcdf006       varchar2(20)      ,/* 工單編號/在制代號 */
xcdf007       varchar2(10)      ,/* 作業編號 */
xcdf008       varchar2(10)      ,/* 製程序 */
xcdf009       varchar2(40)      ,/* 元件料號 */
xcdf010       varchar2(256)      ,/* 特性 */
xcdf011       varchar2(30)      ,/* 批號 */
xcdf012       varchar2(10)      ,/* 成本次要素 */
xcdf020       varchar2(10)      ,/* 核算幣別 */
xcdf101       number(20,6)      ,/* 上期結存數量 */
xcdf102       number(20,6)      ,/* 上期結存金額 */
xcdf201       number(20,6)      ,/* 本期本站投入數量 */
xcdf202       number(20,6)      ,/* 本期本站投入金額 */
xcdf203       number(20,6)      ,/* 本期前製程轉入數量 */
xcdf204       number(20,6)      ,/* 本期前製程轉入金額 */
xcdf205       number(20,6)      ,/* 本期當站下線數量 */
xcdf206       number(20,6)      ,/* 本期當站下線金額 */
xcdf207       number(20,6)      ,/* 本期一般退料數量 */
xcdf208       number(20,6)      ,/* 本期一般退料成本 */
xcdf209       number(20,6)      ,/* 本期超領退數量 */
xcdf210       number(20,6)      ,/* 本期超領退金額 */
xcdf301       number(20,6)      ,/* 本期轉下製程數量 */
xcdf302       number(20,6)      ,/* 本期轉下製程金額 */
xcdf303       number(20,6)      ,/* 本期報廢數量 */
xcdf304       number(20,6)      ,/* 本期報廢金額 */
xcdf309       number(20,6)      ,/* 盤差數量 */
xcdf310       number(20,6)      ,/* 盤差金額 */
xcdf331       number(20,6)      ,/* 差異轉出數量 */
xcdf332       number(20,6)      ,/* 差異轉出金額 */
xcdf901       number(20,6)      ,/* 期末結存數量 */
xcdf902       number(20,6)      ,/* 期末結存金額 */
xcdftime       timestamp(0)      /* 最近成本計算時間 */
);
alter table xcdf_t add constraint xcdf_pk primary key (xcdfent,xcdfld,xcdf001,xcdf002,xcdf003,xcdf004,xcdf005,xcdf006,xcdf007,xcdf008,xcdf009,xcdf010,xcdf011,xcdf012) enable validate;

create unique index xcdf_pk on xcdf_t (xcdfent,xcdfld,xcdf001,xcdf002,xcdf003,xcdf004,xcdf005,xcdf006,xcdf007,xcdf008,xcdf009,xcdf010,xcdf011,xcdf012);

grant select on xcdf_t to tiptop;
grant update on xcdf_t to tiptop;
grant delete on xcdf_t to tiptop;
grant insert on xcdf_t to tiptop;

exit;
