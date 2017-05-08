/* 
================================================================================
檔案代號:pjcd_t
檔案名稱:專案在製成本期異動統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table pjcd_t
(
pjcdent       number(5)      ,/* 企業編號 */
pjcdcomp       varchar2(10)      ,/* 法人組織 */
pjcdld       varchar2(5)      ,/* 帳套 */
pjcd001       varchar2(1)      ,/* 帳套本位幣順序 */
pjcd002       varchar2(20)      ,/* 成本域(專案代號) */
pjcd003       varchar2(10)      ,/* 成本計算類型 */
pjcd004       number(5,0)      ,/* 年度 */
pjcd005       number(5,0)      ,/* 期別 */
pjcd011       varchar2(10)      ,/* 核算幣別 */
pjcd102       number(20,6)      ,/* 上期結存金額 */
pjcd102a       number(20,6)      ,/* 上期結存金額-材料 */
pjcd102b       number(20,6)      ,/* 上期結存金額-人工 */
pjcd102c       number(20,6)      ,/* 上期結存金額-加工 */
pjcd102d       number(20,6)      ,/* 上期結存金額-制費一 */
pjcd102e       number(20,6)      ,/* 上期結存金額-製費二 */
pjcd102f       number(20,6)      ,/* 上期結存金額-製費三 */
pjcd102g       number(20,6)      ,/* 上期結存金額-制費四 */
pjcd102h       number(20,6)      ,/* 上期結存金額-製費五 */
pjcd202       number(20,6)      ,/* 本期投入金額 */
pjcd202a       number(20,6)      ,/* 本期投入金額-材料 */
pjcd202b       number(20,6)      ,/* 本期投入金額-人工 */
pjcd202c       number(20,6)      ,/* 本期投入金額-加工 */
pjcd202d       number(20,6)      ,/* 本期投入金額-制費一 */
pjcd202e       number(20,6)      ,/* 本期投入金額-制費二 */
pjcd202f       number(20,6)      ,/* 本期投入金額-制費三 */
pjcd202g       number(20,6)      ,/* 本期投入金額-制費四 */
pjcd202h       number(20,6)      ,/* 本期投入金額-制費五 */
pjcd902       number(20,6)      ,/* 期末結存金額 */
pjcd902a       number(20,6)      ,/* 期末結存金額-材料 */
pjcd902b       number(20,6)      ,/* 期末結存金額-人工 */
pjcd902c       number(20,6)      ,/* 期末結存金額-加工 */
pjcd902d       number(20,6)      ,/* 期末結存金額-制費一 */
pjcd902e       number(20,6)      ,/* 期末結存金額-製費二 */
pjcd902f       number(20,6)      ,/* 期末結存金額-制費三 */
pjcd902g       number(20,6)      ,/* 期末結存金額-製費四 */
pjcd902h       number(20,6)      ,/* 期末結存金額-制費五 */
pjcdtime       timestamp(0)      /* 最近成本計算時間 */
);
alter table pjcd_t add constraint pjcd_pk primary key (pjcdent,pjcdld,pjcd001,pjcd002,pjcd003,pjcd004,pjcd005) enable validate;

create unique index pjcd_pk on pjcd_t (pjcdent,pjcdld,pjcd001,pjcd002,pjcd003,pjcd004,pjcd005);

grant select on pjcd_t to tiptop;
grant update on pjcd_t to tiptop;
grant delete on pjcd_t to tiptop;
grant insert on pjcd_t to tiptop;

exit;
