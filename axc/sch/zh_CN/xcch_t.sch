/* 
================================================================================
檔案代號:xcch_t
檔案名稱:拆件在制主件成本期異動統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcch_t
(
xcchent       number(5)      ,/* 企業編號 */
xcchcomp       varchar2(10)      ,/* 法人組織 */
xcchld       varchar2(5)      ,/* 帳套 */
xcch001       varchar2(1)      ,/* 帳套本位幣順序 */
xcch002       varchar2(30)      ,/* 成本域 */
xcch003       varchar2(10)      ,/* 成本計算類型 */
xcch004       number(5,0)      ,/* 年度 */
xcch005       number(5,0)      ,/* 期別 */
xcch006       varchar2(20)      ,/* 拆件工單編號 */
xcch007       varchar2(40)      ,/* 主件料號 */
xcch008       varchar2(256)      ,/* 特性 */
xcch009       varchar2(30)      ,/* 批號 */
xcch010       varchar2(20)      ,/* 項目號 */
xcch011       varchar2(10)      ,/* 核算幣別 */
xcch101       number(20,6)      ,/* 上期結存數量 */
xcch102       number(20,6)      ,/* 上期結存金額 */
xcch102a       number(20,6)      ,/* 上期結存金額-材料 */
xcch102b       number(20,6)      ,/* 上期結存金額-人工 */
xcch102c       number(20,6)      ,/* 上期結存金額-加工 */
xcch102d       number(20,6)      ,/* 上期結存金額-制費一 */
xcch102e       number(20,6)      ,/* 上期結存金額-制費二 */
xcch102f       number(20,6)      ,/* 上期結存金額-制費三 */
xcch102g       number(20,6)      ,/* 上期結存金額-制費四 */
xcch102h       number(20,6)      ,/* 上期結存金額-制費五 */
xcch200       number(20,6)      ,/* 本期投入工時 */
xcch201       number(20,6)      ,/* 本期投入數量 */
xcch202       number(20,6)      ,/* 本期本階投入金額 */
xcch202a       number(20,6)      ,/* 本期本階投入金額-材料 */
xcch202b       number(20,6)      ,/* 本期本階投入金額-人工 */
xcch202c       number(20,6)      ,/* 本期本階投入金額-加工 */
xcch202d       number(20,6)      ,/* 本期本階投入金額-制費一 */
xcch202e       number(20,6)      ,/* 本期本階投入金額-制費二 */
xcch202f       number(20,6)      ,/* 本期本階投入金額-制費三 */
xcch202g       number(20,6)      ,/* 本期本階投入金額-制費四 */
xcch202h       number(20,6)      ,/* 本期本階投入金額-制費五 */
xcch204       number(20,6)      ,/* 本期下階投入金額 */
xcch204a       number(20,6)      ,/* 本期下階投入金額-材料 */
xcch204b       number(20,6)      ,/* 本期下階投入金額-人工 */
xcch204c       number(20,6)      ,/* 本期下階投入金額-加工 */
xcch204d       number(20,6)      ,/* 本期下階投入金額-制費一 */
xcch204e       number(20,6)      ,/* 本期下階投入金額-制費二 */
xcch204f       number(20,6)      ,/* 本期下階投入金額-制費三 */
xcch204g       number(20,6)      ,/* 本期下階投入金額-制費四 */
xcch204h       number(20,6)      ,/* 本期下階投入金額-制費五 */
xcch301       number(20,6)      ,/* 本期轉出數量 */
xcch302       number(20,6)      ,/* 本期轉出金額 */
xcch302a       number(20,6)      ,/* 本期轉出金額-材料 */
xcch302b       number(20,6)      ,/* 本期轉出金額-人工 */
xcch302c       number(20,6)      ,/* 本期轉出金額-加工 */
xcch302d       number(20,6)      ,/* 本期轉出金額-制費一 */
xcch302e       number(20,6)      ,/* 本期轉出金額-制費二 */
xcch302f       number(20,6)      ,/* 本期轉出金額-制費三 */
xcch302g       number(20,6)      ,/* 本期轉出金額-制費四 */
xcch302h       number(20,6)      ,/* 本期轉出金額-制費五 */
xcch303       number(20,6)      ,/* 差異轉出數量 */
xcch304       number(20,6)      ,/* 差異轉出金額 */
xcch304a       number(20,6)      ,/* 差異轉出金額-材料 */
xcch304b       number(20,6)      ,/* 差異轉出金額-人工 */
xcch304c       number(20,6)      ,/* 差異轉出金額-加工 */
xcch304d       number(20,6)      ,/* 差異轉出金額-制費一 */
xcch304e       number(20,6)      ,/* 差異轉出金額-制費二 */
xcch304f       number(20,6)      ,/* 差異轉出金額-制費三 */
xcch304g       number(20,6)      ,/* 差異轉出金額-制費四 */
xcch304h       number(20,6)      ,/* 差異轉出金額-制費五 */
xcch901       number(20,6)      ,/* 期末結存數量 */
xcch902       number(20,6)      ,/* 期末結存金額 */
xcch902a       number(20,6)      ,/* 期末結存金額-材料 */
xcch902b       number(20,6)      ,/* 期末結存金額-人工 */
xcch902c       number(20,6)      ,/* 期末結存金額-加工 */
xcch902d       number(20,6)      ,/* 期末結存金額-制費一 */
xcch902e       number(20,6)      ,/* 期末結存金額-制費二 */
xcch902f       number(20,6)      ,/* 期末結存金額-制費三 */
xcch902g       number(20,6)      ,/* 期末結存金額-制費四 */
xcch902h       number(20,6)      ,/* 期末結存金額-制費五 */
xcchtime       timestamp(0)      /* 最近成本計算時間 */
);
alter table xcch_t add constraint xcch_pk primary key (xcchent,xcchld,xcch001,xcch002,xcch003,xcch004,xcch005,xcch006) enable validate;

create unique index xcch_pk on xcch_t (xcchent,xcchld,xcch001,xcch002,xcch003,xcch004,xcch005,xcch006);

grant select on xcch_t to tiptop;
grant update on xcch_t to tiptop;
grant delete on xcch_t to tiptop;
grant insert on xcch_t to tiptop;

exit;
