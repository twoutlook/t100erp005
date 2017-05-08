/* 
================================================================================
檔案代號:pjcc_t
檔案名稱:專案庫存成本期異動統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table pjcc_t
(
pjccent       number(5)      ,/* 企業編號 */
pjcccomp       varchar2(10)      ,/* 法人組織 */
pjccld       varchar2(5)      ,/* 帳套 */
pjcc001       varchar2(1)      ,/* 帳套本位幣順序 */
pjcc002       varchar2(20)      ,/* 成本域(專案代號) */
pjcc003       varchar2(10)      ,/* 成本計算類型 */
pjcc004       number(5,0)      ,/* 年度 */
pjcc005       number(5,0)      ,/* 期別 */
pjcc010       varchar2(10)      ,/* 核算幣別 */
pjcc102       number(20,6)      ,/* 上期結存金額 */
pjcc102a       number(20,6)      ,/* 上期結存金額-材料 */
pjcc102b       number(20,6)      ,/* 上期結存金額-人工 */
pjcc102c       number(20,6)      ,/* 上期結存金額-加工 */
pjcc102d       number(20,6)      ,/* 上期結存金額-制費一 */
pjcc102e       number(20,6)      ,/* 上期結存金額-製費二 */
pjcc102f       number(20,6)      ,/* 上期結存金額-製費三 */
pjcc102g       number(20,6)      ,/* 上期結存金額-制費四 */
pjcc102h       number(20,6)      ,/* 上期結存金額-製費五 */
pjcc202       number(20,6)      ,/* 本期入庫金額 */
pjcc202a       number(20,6)      ,/* 本期入庫金額-材料 */
pjcc202b       number(20,6)      ,/* 本期入庫金額-人工 */
pjcc202c       number(20,6)      ,/* 本期入庫金額-加工 */
pjcc202d       number(20,6)      ,/* 本期入庫金額-制費一 */
pjcc202e       number(20,6)      ,/* 本期入庫金額-制費二 */
pjcc202f       number(20,6)      ,/* 本期入庫金額-制費三 */
pjcc202g       number(20,6)      ,/* 本期入庫金額-制費四 */
pjcc202h       number(20,6)      ,/* 本期入庫金額-制費五 */
pjcc902       number(20,6)      ,/* 期末結存金額 */
pjcc902a       number(20,6)      ,/* 期末結存金額-材料 */
pjcc902b       number(20,6)      ,/* 期末結存金額-人工 */
pjcc902c       number(20,6)      ,/* 期末結存金額-加工 */
pjcc902d       number(20,6)      ,/* 期末結存金額-制費一 */
pjcc902e       number(20,6)      ,/* 期末結存金額-製費二 */
pjcc902f       number(20,6)      ,/* 期末結存金額-制費三 */
pjcc902g       number(20,6)      ,/* 期末結存金額-製費四 */
pjcc902h       number(20,6)      ,/* 期末結存金額-制費五 */
pjcctime       timestamp(0)      ,/* 最近成本計算時間 */
pjcc101       number(20,6)      ,/* 上期預收款 */
pjcc201       number(20,6)      ,/* 本期預收款 */
pjcc901       number(20,6)      ,/* 累計預收款 */
pjcc112       number(20,6)      ,/* 上期現場投入合計 */
pjcc112a       number(20,6)      ,/* 上期現場投入-材料 */
pjcc112b       number(20,6)      ,/* 上期現場投入-包作 */
pjcc112c       number(20,6)      ,/* 上期現場投入-人工 */
pjcc112d       number(20,6)      ,/* 上期現場投入-費用 */
pjcc112e       number(20,6)      ,/* 上期現場投入-其他 */
pjcc212       number(20,6)      ,/* 本期現場投入合計 */
pjcc212a       number(20,6)      ,/* 本期現場投入-材料 */
pjcc212b       number(20,6)      ,/* 本期現場投入-包作 */
pjcc212c       number(20,6)      ,/* 本期現場投入-人工 */
pjcc212d       number(20,6)      ,/* 本期現場投入-費用 */
pjcc212e       number(20,6)      ,/* 本期現場投入-其它 */
pjcc912       number(20,6)      ,/* 期末現場投入合計 */
pjcc912a       number(20,6)      ,/* 期末現場投入-材料 */
pjcc912b       number(20,6)      ,/* 期末現場投入-包作 */
pjcc912c       number(20,6)      ,/* 期末現場投入-人工 */
pjcc912d       number(20,6)      ,/* 期末現場投入-費用 */
pjcc912e       number(20,6)      ,/* 期末現場投入-其它 */
pjcc103       number(20,6)      ,/* 上期專案成本合計 */
pjcc103a       number(20,6)      ,/* 上期專案成本-材料 */
pjcc103b       number(20,6)      ,/* 上期專案成本-包作 */
pjcc103c       number(20,6)      ,/* 上期專案成本-人工 */
pjcc103d       number(20,6)      ,/* 上期專案成本-費用 */
pjcc103e       number(20,6)      ,/* 上期專案成本-其它 */
pjcc103f       number(20,6)      ,/* 上期專案成本-虧損 */
pjcc104       number(20,6)      ,/* 上期專案收入 */
pjcc204       number(20,6)      ,/* 本期專案收入 */
pjcc904       number(20,6)      ,/* 累計專案收入 */
pjcc105       number(20,6)      ,/* 上期在建利益 */
pjcc205       number(20,6)      ,/* 本期在建利益 */
pjcc905       number(20,6)      ,/* 累計在建利益 */
pjcc106       number(20,6)      ,/* 上期在建損失 */
pjcc206       number(20,6)      ,/* 本期在建損失 */
pjcc906       number(20,6)      ,/* 累計在建損失 */
pjcc203       number(20,6)      ,/* 本期專案成本合計 */
pjcc203a       number(20,6)      ,/* 本期專案成本-材料 */
pjcc203b       number(20,6)      ,/* 本期專案成本-包作 */
pjcc203c       number(20,6)      ,/* 本期專案成本-人工 */
pjcc203d       number(20,6)      ,/* 本期專案成本-費用 */
pjcc203e       number(20,6)      ,/* 本期專案成本-其他 */
pjcc203f       number(20,6)      ,/* 本期專案成本-虧損 */
pjcc903       number(20,6)      ,/* 期末專案成本合計 */
pjcc903a       number(20,6)      ,/* 期末專案成本-材料 */
pjcc903b       number(20,6)      ,/* 期末專案成本-包作 */
pjcc903c       number(20,6)      ,/* 期末專案成本-人工 */
pjcc903d       number(20,6)      ,/* 期末專案成本-費用 */
pjcc903e       number(20,6)      ,/* 期末專案成本-其他 */
pjcc903f       number(20,6)      /* 期末專案成本-虧損 */
);
alter table pjcc_t add constraint pjcc_pk primary key (pjccent,pjccld,pjcc001,pjcc002,pjcc003,pjcc004,pjcc005) enable validate;

create unique index pjcc_pk on pjcc_t (pjccent,pjccld,pjcc001,pjcc002,pjcc003,pjcc004,pjcc005);

grant select on pjcc_t to tiptop;
grant update on pjcc_t to tiptop;
grant delete on pjcc_t to tiptop;
grant insert on pjcc_t to tiptop;

exit;
