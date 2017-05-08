/* 
================================================================================
檔案代號:xcce_t
檔案名稱:在制元件成本期異動統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcce_t
(
xcceent       number(5)      ,/* 企業編號 */
xccecomp       varchar2(10)      ,/* 法人組織 */
xcceld       varchar2(5)      ,/* 帳套 */
xcce001       varchar2(1)      ,/* 帳套本位幣順序 */
xcce002       varchar2(30)      ,/* 成本域 */
xcce003       varchar2(10)      ,/* 成本計算類型 */
xcce004       number(5,0)      ,/* 年度 */
xcce005       number(5,0)      ,/* 期別 */
xcce006       varchar2(20)      ,/* 工單編號 */
xcce007       varchar2(40)      ,/* 元件編號 */
xcce008       varchar2(256)      ,/* 特性 */
xcce009       varchar2(30)      ,/* 批號 */
xcce010       varchar2(10)      ,/* 核算幣別 */
xcce101       number(20,6)      ,/* 上期結存數量 */
xcce102       number(20,6)      ,/* 上期結存金額 */
xcce102a       number(20,6)      ,/* 上期結存金額-材料 */
xcce102b       number(20,6)      ,/* 上期結存金額-人工 */
xcce102c       number(20,6)      ,/* 上期結存金額-加工 */
xcce102d       number(20,6)      ,/* 上期結存金額-制費一 */
xcce102e       number(20,6)      ,/* 上期結存金額-制費二 */
xcce102f       number(20,6)      ,/* 上期結存金額-制費三 */
xcce102g       number(20,6)      ,/* 上期結存金額-制費四 */
xcce102h       number(20,6)      ,/* 上期結存金額-制費五 */
xcce201       number(20,6)      ,/* 本期投入數量 */
xcce202       number(20,6)      ,/* 本期本階投入金額 */
xcce202a       number(20,6)      ,/* 本期本階投入金額-材料 */
xcce202b       number(20,6)      ,/* 本期本階投入金額-人工 */
xcce202c       number(20,6)      ,/* 本期本階投入金額-加工 */
xcce202d       number(20,6)      ,/* 本期本階投入金額-制費一 */
xcce202e       number(20,6)      ,/* 本期本階投入金額-制費二 */
xcce202f       number(20,6)      ,/* 本期本階投入金額-制費三 */
xcce202g       number(20,6)      ,/* 本期本階投入金額-制費四 */
xcce202h       number(20,6)      ,/* 本期本階投入金額-制費五 */
xcce205       number(20,6)      ,/* 本期當站下線數量 */
xcce206       number(20,6)      ,/* 本期當站下線成本 */
xcce206a       number(20,6)      ,/* 本期當站下線成本-材料 */
xcce206b       number(20,6)      ,/* 本期當站下線成本-人工 */
xcce206c       number(20,6)      ,/* 本期當站下線成本-加工 */
xcce206d       number(20,6)      ,/* 本期當站下線成本-制費一 */
xcce206e       number(20,6)      ,/* 本期當站下線成本-制費二 */
xcce206f       number(20,6)      ,/* 本期當站下線成本-制費三 */
xcce206g       number(20,6)      ,/* 本期當站下線成本-制費四 */
xcce206h       number(20,6)      ,/* 本期當站下線成本-制費五 */
xcce207       number(20,6)      ,/* 本期一般退料數量 */
xcce208       number(20,6)      ,/* 本期一般退料成本 */
xcce208a       number(20,6)      ,/* 本期一般退料成本-材料 */
xcce208b       number(20,6)      ,/* 本期一般退料成本-人工 */
xcce208c       number(20,6)      ,/* 本期一般退料成本-加工 */
xcce208d       number(20,6)      ,/* 本期一般退料成本-制費一 */
xcce208e       number(20,6)      ,/* 本期一般退料成本-制費二 */
xcce208f       number(20,6)      ,/* 本期一般退料成本-制費三 */
xcce208g       number(20,6)      ,/* 本期一般退料成本-制費四 */
xcce208h       number(20,6)      ,/* 本期一般退料成本-制費五 */
xcce209       number(20,6)      ,/* 本期超領退數量 */
xcce210       number(20,6)      ,/* 本期超領退金額 */
xcce210a       number(20,6)      ,/* 本期超領退金額-材料 */
xcce210b       number(20,6)      ,/* 本期超領退金額-人工 */
xcce210c       number(20,6)      ,/* 本期超領退金額-加工 */
xcce210d       number(20,6)      ,/* 本期超領退金額-制費一 */
xcce210e       number(20,6)      ,/* 本期超領退金額-制費二 */
xcce210f       number(20,6)      ,/* 本期超領退金額-制費三 */
xcce210g       number(20,6)      ,/* 本期超領退金額-制費四 */
xcce210h       number(20,6)      ,/* 本期超領退金額-制費五 */
xcce301       number(20,6)      ,/* 本期轉出數量 */
xcce302       number(20,6)      ,/* 本期轉出金額 */
xcce302a       number(20,6)      ,/* 本期轉出金額-材料 */
xcce302b       number(20,6)      ,/* 本期轉出金額-人工 */
xcce302c       number(20,6)      ,/* 本期轉出金額-加工 */
xcce302d       number(20,6)      ,/* 本期轉出金額-制費一 */
xcce302e       number(20,6)      ,/* 本期轉出金額-制費二 */
xcce302f       number(20,6)      ,/* 本期轉出金額-制費三 */
xcce302g       number(20,6)      ,/* 本期轉出金額-制費四 */
xcce302h       number(20,6)      ,/* 本期轉出金額-制費五 */
xcce303       number(20,6)      ,/* 差異轉出數量 */
xcce304       number(20,6)      ,/* 差異轉出金額 */
xcce304a       number(20,6)      ,/* 差異轉出金額-材料 */
xcce304b       number(20,6)      ,/* 差異轉出金額-人工 */
xcce304c       number(20,6)      ,/* 差異轉出金額-加工 */
xcce304d       number(20,6)      ,/* 差異轉出金額-制費一 */
xcce304e       number(20,6)      ,/* 差異轉出金額-制費二 */
xcce304f       number(20,6)      ,/* 差異轉出金額-制費三 */
xcce304g       number(20,6)      ,/* 差異轉出金額-制費四 */
xcce304h       number(20,6)      ,/* 差異轉出金額-制費五 */
xcce307       number(20,6)      ,/* 盤差數量 */
xcce308       number(20,6)      ,/* 盤差金額 */
xcce308a       number(20,6)      ,/* 盤差金額-材料 */
xcce308b       number(20,6)      ,/* 盤差金額-人工 */
xcce308c       number(20,6)      ,/* 盤差金額-加工 */
xcce308d       number(20,6)      ,/* 盤差金額-制費一 */
xcce308e       number(20,6)      ,/* 盤差金額-制費二 */
xcce308f       number(20,6)      ,/* 盤差金額-制費三 */
xcce308g       number(20,6)      ,/* 盤差金額-制費四 */
xcce308h       number(20,6)      ,/* 盤差金額-制費五 */
xcce901       number(20,6)      ,/* 期末結存數量 */
xcce902       number(20,6)      ,/* 期末結存金額 */
xcce902a       number(20,6)      ,/* 期末結存金額-材料 */
xcce902b       number(20,6)      ,/* 期末結存金額-人工 */
xcce902c       number(20,6)      ,/* 期末結存金額-加工 */
xcce902d       number(20,6)      ,/* 期末結存金額-制費一 */
xcce902e       number(20,6)      ,/* 期末結存金額-制費二 */
xcce902f       number(20,6)      ,/* 期末結存金額-制費三 */
xcce902g       number(20,6)      ,/* 期末結存金額-制費四 */
xcce902h       number(20,6)      ,/* 期末結存金額-制費五 */
xccetime       timestamp(0)      /* 最近成本計算時間 */
);
alter table xcce_t add constraint xcce_pk primary key (xcceent,xcceld,xcce001,xcce002,xcce003,xcce004,xcce005,xcce006,xcce007,xcce008,xcce009) enable validate;

create unique index xcce_pk on xcce_t (xcceent,xcceld,xcce001,xcce002,xcce003,xcce004,xcce005,xcce006,xcce007,xcce008,xcce009);

grant select on xcce_t to tiptop;
grant update on xcce_t to tiptop;
grant delete on xcce_t to tiptop;
grant insert on xcce_t to tiptop;

exit;
