/* 
================================================================================
檔案代號:xccn_t
檔案名稱:本期在制轉出成本與工單入庫標準成本差異檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xccn_t
(
xccnent       number(5)      ,/* 企業代碼 */
xccncomp       varchar2(10)      ,/* 法人 */
xccnld       varchar2(5)      ,/* 帳別 */
xccn001       varchar2(1)      ,/* 帳套本位幣順序 */
xccn002       varchar2(30)      ,/* 成本域 */
xccn003       varchar2(10)      ,/* 成本計算類型 */
xccn004       number(5,0)      ,/* 年度 */
xccn005       number(5,0)      ,/* 期別 */
xccn006       varchar2(20)      ,/* 工單編號 */
xccn102       number(20,6)      ,/* 在制轉出金額 */
xccn102a       number(20,6)      ,/* 在制轉出金額-材料 */
xccn102b       number(20,6)      ,/* 在制轉出金額-人工 */
xccn102c       number(20,6)      ,/* 在制轉出金額-委外 */
xccn102d       number(20,6)      ,/* 在制轉出金額-制費一 */
xccn102e       number(20,6)      ,/* 在制轉出金額-制費二 */
xccn102f       number(20,6)      ,/* 在制轉出金額-制費三 */
xccn102g       number(20,6)      ,/* 在制轉出金額-制費四 */
xccn102h       number(20,6)      ,/* 在制轉出金額-制費五 */
xccn202       number(20,6)      ,/* 入庫標準成本金額 */
xccn202a       number(20,6)      ,/* 入庫標準成本金額-材料 */
xccn202b       number(20,6)      ,/* 入庫標準成本金額-人工 */
xccn202c       number(20,6)      ,/* 入庫標準成本金額-委外 */
xccn202d       number(20,6)      ,/* 入庫標準成本金額-制費一 */
xccn202e       number(20,6)      ,/* 入庫標準成本金額-制費二 */
xccn202f       number(20,6)      ,/* 入庫標準成本金額-制費三 */
xccn202g       number(20,6)      ,/* 入庫標準成本金額-制費四 */
xccn202h       number(20,6)      ,/* 入庫標準成本金額-制費五 */
xccn302       number(20,6)      ,/* 差異金額 */
xccn302a       number(20,6)      ,/* 差異金額-材料 */
xccn302b       number(20,6)      ,/* 差異金額-人工 */
xccn302c       number(20,6)      ,/* 差異金額-加工費 */
xccn302d       number(20,6)      ,/* 差異金額-制費一 */
xccn302e       number(20,6)      ,/* 差異金額-制費二 */
xccn302f       number(20,6)      ,/* 差異金額-制費三 */
xccn302g       number(20,6)      ,/* 差異金額-制費四 */
xccn302h       number(20,6)      /* 差異金額-制費五 */
);
alter table xccn_t add constraint xccn_pk primary key (xccnent,xccnld,xccn001,xccn002,xccn003,xccn004,xccn005,xccn006) enable validate;

create unique index xccn_pk on xccn_t (xccnent,xccnld,xccn001,xccn002,xccn003,xccn004,xccn005,xccn006);

grant select on xccn_t to tiptop;
grant update on xccn_t to tiptop;
grant delete on xccn_t to tiptop;
grant insert on xccn_t to tiptop;

exit;
