/* 
================================================================================
檔案代號:xcde_t
檔案名稱:在製成本次要素期異動統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcde_t
(
xcdeent       number(5)      ,/* 企業編號 */
xcdecomp       varchar2(10)      ,/* 法人組織 */
xcdeld       varchar2(5)      ,/* 賬套 */
xcde001       varchar2(1)      ,/* 賬套本位幣順序 */
xcde002       varchar2(30)      ,/* 成本域 */
xcde003       varchar2(10)      ,/* 成本計算類型 */
xcde004       number(5,0)      ,/* 年度 */
xcde005       number(5,0)      ,/* 期別 */
xcde006       varchar2(20)      ,/* 工單編號/在制代號 */
xcde007       varchar2(40)      ,/* 元件料號 */
xcde008       varchar2(256)      ,/* 特性 */
xcde009       varchar2(30)      ,/* 批號 */
xcde010       varchar2(10)      ,/* 成本次要素 */
xcde020       varchar2(10)      ,/* 核算幣別 */
xcde101       number(20,6)      ,/* 上期結存數量 */
xcde102       number(20,6)      ,/* 上期結存金額 */
xcde201       number(20,6)      ,/* 本期投入數量 */
xcde202       number(20,6)      ,/* 本期本階投入金額 */
xcde205       number(20,6)      ,/* 本期當站下線數量 */
xcde206       number(20,6)      ,/* 本期當站下線成本 */
xcde207       number(20,6)      ,/* 本期一般退料數量 */
xcde208       number(20,6)      ,/* 本期一般退料成本 */
xcde209       number(20,6)      ,/* 本期超領退數量 */
xcde210       number(20,6)      ,/* 本期超領退金額 */
xcde301       number(20,6)      ,/* 本期轉出數量 */
xcde302       number(20,6)      ,/* 本期轉出金額 */
xcde303       number(20,6)      ,/* 差異轉出數量 */
xcde304       number(20,6)      ,/* 差異轉出金額 */
xcde307       number(20,6)      ,/* 盤差數量 */
xcde308       number(20,6)      ,/* 盤差金額 */
xcde901       number(20,6)      ,/* 期末結存數量 */
xcde902       number(20,6)      ,/* 期末結存金額 */
xcdetime       timestamp(0)      /* 最近成本計算時間 */
);
alter table xcde_t add constraint xcde_pk primary key (xcdeent,xcdeld,xcde001,xcde002,xcde003,xcde004,xcde005,xcde006,xcde007,xcde008,xcde009,xcde010) enable validate;

create unique index xcde_pk on xcde_t (xcdeent,xcdeld,xcde001,xcde002,xcde003,xcde004,xcde005,xcde006,xcde007,xcde008,xcde009,xcde010);

grant select on xcde_t to tiptop;
grant update on xcde_t to tiptop;
grant delete on xcde_t to tiptop;
grant insert on xcde_t to tiptop;

exit;
