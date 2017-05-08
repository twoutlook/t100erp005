/* 
================================================================================
檔案代號:xcci_t
檔案名稱:拆件在製元件成本期異動統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcci_t
(
xccient       number(5)      ,/* 企業編號 */
xccicomp       varchar2(10)      ,/* 法人組織 */
xccild       varchar2(5)      ,/* 帳套 */
xcci001       varchar2(1)      ,/* 帳套本位幣順序 */
xcci002       varchar2(30)      ,/* 成本域 */
xcci003       varchar2(10)      ,/* 成本計算類型 */
xcci004       number(5,0)      ,/* 年度 */
xcci005       number(5,0)      ,/* 期別 */
xcci006       varchar2(20)      ,/* 拆件工單編號 */
xcci007       varchar2(40)      ,/* 元件料號 */
xcci008       varchar2(256)      ,/* 特性 */
xcci009       varchar2(30)      ,/* 批號 */
xcci010       varchar2(10)      ,/* 核算幣別 */
xcci101       number(20,6)      ,/* 上期結存數量 */
xcci102       number(20,6)      ,/* 上期結存金額 */
xcci102a       number(20,6)      ,/* 上期結存金額-材料 */
xcci102b       number(20,6)      ,/* 上期結存金額-人工 */
xcci102c       number(20,6)      ,/* 上期結存金額-加工 */
xcci102d       number(20,6)      ,/* 上期結存金額-制費一 */
xcci102e       number(20,6)      ,/* 上期結存金額-制費二 */
xcci102f       number(20,6)      ,/* 上期結存金額-制費三 */
xcci102g       number(20,6)      ,/* 上期結存金額-制費四 */
xcci102h       number(20,6)      ,/* 上期結存金額-制費五 */
xcci201       number(20,6)      ,/* 本期投入數量 */
xcci202       number(20,6)      ,/* 本期本階投入金額 */
xcci202a       number(20,6)      ,/* 本期本階投入金額-材料 */
xcci202b       number(20,6)      ,/* 本期本階投入金額-人工 */
xcci202c       number(20,6)      ,/* 本期本階投入金額-加工 */
xcci202d       number(20,6)      ,/* 本期本階投入金額-制費一 */
xcci202e       number(20,6)      ,/* 本期本階投入金額-制費二 */
xcci202f       number(20,6)      ,/* 本期本階投入金額-制費三 */
xcci202g       number(20,6)      ,/* 本期本階投入金額-制費四 */
xcci202h       number(20,6)      ,/* 本期本階投入金額-制費五 */
xcci301       number(20,6)      ,/* 本期轉出數量 */
xcci302       number(20,6)      ,/* 本期轉出金額 */
xcci302a       number(20,6)      ,/* 本期轉出金額-材料 */
xcci302b       number(20,6)      ,/* 本期轉出金額-人工 */
xcci302c       number(20,6)      ,/* 本期轉出金額-加工 */
xcci302d       number(20,6)      ,/* 本期轉出金額-制費一 */
xcci302e       number(20,6)      ,/* 本期轉出金額-制費二 */
xcci302f       number(20,6)      ,/* 本期轉出金額-制費三 */
xcci302g       number(20,6)      ,/* 本期轉出金額-制費四 */
xcci302h       number(20,6)      ,/* 本期轉出金額-制費五 */
xcci303       number(20,6)      ,/* 差異轉出數量 */
xcci304       number(20,6)      ,/* 差異轉出金額 */
xcci304a       number(20,6)      ,/* 差異轉出金額-材料 */
xcci304b       number(20,6)      ,/* 差異轉出金額-人工 */
xcci304c       number(20,6)      ,/* 差異轉出金額-加工 */
xcci304d       number(20,6)      ,/* 差異轉出金額-制費一 */
xcci304e       number(20,6)      ,/* 差異轉出金額-制費二 */
xcci304f       number(20,6)      ,/* 差異轉出金額-制費三 */
xcci304g       number(20,6)      ,/* 差異轉出金額-制費四 */
xcci304h       number(20,6)      ,/* 差異轉出金額-制費五 */
xcci901       number(20,6)      ,/* 期末結存數量 */
xcci902       number(20,6)      ,/* 期末結存金額 */
xcci902a       number(20,6)      ,/* 期末結存金額-材料 */
xcci902b       number(20,6)      ,/* 期末結存金額-人工 */
xcci902c       number(20,6)      ,/* 期末結存金額-加工 */
xcci902d       number(20,6)      ,/* 期末結存金額-制費一 */
xcci902e       number(20,6)      ,/* 期末結存金額-制費二 */
xcci902f       number(20,6)      ,/* 期末結存金額-制費三 */
xcci902g       number(20,6)      ,/* 期末結存金額-制費四 */
xcci902h       number(20,6)      ,/* 期末結存金額-制費五 */
xccitime       timestamp(0)      /* 最近成本計算時間 */
);
alter table xcci_t add constraint xcci_pk primary key (xccient,xccild,xcci001,xcci002,xcci003,xcci004,xcci005,xcci006,xcci007,xcci008,xcci009) enable validate;

create unique index xcci_pk on xcci_t (xccient,xccild,xcci001,xcci002,xcci003,xcci004,xcci005,xcci006,xcci007,xcci008,xcci009);

grant select on xcci_t to tiptop;
grant update on xcci_t to tiptop;
grant delete on xcci_t to tiptop;
grant insert on xcci_t to tiptop;

exit;
