/* 
================================================================================
檔案代號:xccf_t
檔案名稱:在制元件工藝成本期異動統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xccf_t
(
xccfent       number(5)      ,/* 企業代碼 */
xccfcomp       varchar2(10)      ,/* 法人 */
xccfld       varchar2(5)      ,/* 帳套 */
xccf001       varchar2(1)      ,/* 帳套本位幣順序 */
xccf002       varchar2(30)      ,/* 成本域 */
xccf003       varchar2(10)      ,/* 成本計算類型 */
xccf004       number(5,0)      ,/* 年度 */
xccf005       number(5,0)      ,/* 期別 */
xccf006       varchar2(20)      ,/* 工單編號/在制代號 */
xccf007       varchar2(40)      ,/* 元件料號 */
xccf008       varchar2(256)      ,/* 特性 */
xccf009       varchar2(30)      ,/* 批號 */
xccf010       varchar2(10)      ,/* 工藝序 */
xccf011       varchar2(10)      ,/* 轉入來源工藝 */
xccf012       varchar2(10)      ,/* 轉入來源工藝序 */
xccf013       varchar2(10)      ,/* 核算幣別 */
xccf014       timestamp(0)      ,/* 最近成本計算時間 */
xccf101       number(5,0)      ,/* 上期結存數量 */
xccf102       number(20,6)      ,/* 上期結存金額 */
xccf102a       number(20,6)      ,/* 上期結存金額-材料 */
xccf102b       number(20,6)      ,/* 上期結存金額-人工 */
xccf102c       number(20,6)      ,/* 上期結存金額-加工 */
xccf102d       number(20,6)      ,/* 上期結存金額-制費一 */
xccf102e       number(20,6)      ,/* 上期結存金額-製費二 */
xccf102f       number(20,6)      ,/* 上期結存金額-製費三 */
xccf102g       number(20,6)      ,/* 上期結存金額-制費四 */
xccf102h       number(20,6)      ,/* 上期結存金額-制費五 */
xccf201       number(20,6)      ,/* 本期本站投入數量 */
xccf202       number(20,6)      ,/* 本期本站投入金額 */
xccf202a       number(20,6)      ,/* 本期本站投入金額-材料 */
xccf202b       number(20,6)      ,/* 本期本站投入金額-人工 */
xccf202c       number(20,6)      ,/* 本期本站投入金額-加工 */
xccf202d       number(20,6)      ,/* 本期本站投入金額-制費一 */
xccf202e       number(20,6)      ,/* 本期本站投入金額-制費二 */
xccf202f       number(20,6)      ,/* 本期本站投入金額-制費三 */
xccf202g       number(20,6)      ,/* 本期本站投入金額-制費四 */
xccf202h       number(20,6)      ,/* 本期本站投入金額-制費五 */
xccf203       number(20,6)      ,/* 本期前製程轉入數量 */
xccf204       number(20,6)      ,/* 本期前製程轉入金額 */
xccf204a       number(20,6)      ,/* 本期前製程轉入金額-材料 */
xccf204b       number(20,6)      ,/* 本期前製程轉入金額-人工 */
xccf204c       number(20,6)      ,/* 本期前製程轉入金額-加工 */
xccf204d       number(20,6)      ,/* 本期前製程轉入金額-制費一 */
xccf204e       number(20,6)      ,/* 本期前製程轉入金額-制費二 */
xccf204f       number(20,6)      ,/* 本期前製程轉入金額-制費三 */
xccf204g       number(20,6)      ,/* 本期前製程轉入金額-制費四 */
xccf204h       number(20,6)      ,/* 本期前製程轉入金額-制費五 */
xccf205       number(20,6)      ,/* 工單轉入數量 */
xccf206       number(20,6)      ,/* 工單轉入金額 */
xccf206a       number(20,6)      ,/* 工單轉入金額-材料 */
xccf206b       number(20,6)      ,/* 工單轉入金額-人工 */
xccf206c       number(20,6)      ,/* 工單轉入金額-加工 */
xccf206d       number(20,6)      ,/* 工單轉入金額-制費一 */
xccf206e       number(20,6)      ,/* 工單轉入金額-制費二 */
xccf206f       number(20,6)      ,/* 工單轉入金額-制費三 */
xccf206g       number(20,6)      ,/* 工單轉入金額-制費四 */
xccf206h       number(20,6)      ,/* 工單轉入金額-制費五 */
xccf207       number(20,6)      ,/* 重流轉入數量 */
xccf208       number(20,6)      ,/* 重流轉入金額 */
xccf208a       number(20,6)      ,/* 重流轉入金額-材料 */
xccf208b       number(20,6)      ,/* 重流轉入金額-人工 */
xccf208c       number(20,6)      ,/* 重流轉入金額-加工 */
xccf208d       number(20,6)      ,/* 重流轉入金額-制費一 */
xccf208e       number(20,6)      ,/* 重流轉入金額-制費二 */
xccf208f       number(20,6)      ,/* 重流轉入金額-制費三 */
xccf208g       number(20,6)      ,/* 重流轉入金額-制費四 */
xccf208h       number(20,6)      ,/* 重流轉入金額-制費五 */
xccf301       number(20,6)      ,/* 本期轉下製程數量 */
xccf302       number(20,6)      ,/* 本期轉下製程金額 */
xccf302a       number(20,6)      ,/* 本期轉下製程金額-材料 */
xccf302b       number(20,6)      ,/* 本期轉下製程金額-人工 */
xccf302c       number(20,6)      ,/* 本期轉下製程金額-加工 */
xccf302d       number(20,6)      ,/* 本期轉下製程金額-制費一 */
xccf302e       number(20,6)      ,/* 本期轉下製程金額-制費二 */
xccf302f       number(20,6)      ,/* 本期轉下製程金額-制費三 */
xccf302g       number(20,6)      ,/* 本期轉下製程金額-制費四 */
xccf302h       number(20,6)      ,/* 本期轉下製程金額-制費五 */
xccf303       number(20,6)      ,/* 本期報廢數量 */
xccf304       number(20,6)      ,/* 本期報廢金額 */
xccf304a       number(20,6)      ,/* 本期報廢金額-材料 */
xccf304b       number(20,6)      ,/* 本期報廢金額-人工 */
xccf304c       number(20,6)      ,/* 本期報廢金額-加工 */
xccf304d       number(20,6)      ,/* 本期報廢金額-制費一 */
xccf304e       number(20,6)      ,/* 本期報廢金額-制費二 */
xccf304f       number(20,6)      ,/* 本期報廢金額-制費三 */
xccf304g       number(20,6)      ,/* 本期報廢金額-制費四 */
xccf304h       number(20,6)      ,/* 本期報廢金額-制費五 */
xccf305       number(20,6)      ,/* 工單轉出數量 */
xccf306       number(20,6)      ,/* 工單轉出金額 */
xccf306a       number(20,6)      ,/* 工單轉出金額-材料 */
xccf306b       number(20,6)      ,/* 工單轉出金額-人工 */
xccf306c       number(20,6)      ,/* 工單轉出金額-加工 */
xccf306d       number(20,6)      ,/* 工單轉出金額-制費一 */
xccf306e       number(20,6)      ,/* 工單轉出金額-制費二 */
xccf306f       number(20,6)      ,/* 工單轉出金額-制費三 */
xccf306g       number(20,6)      ,/* 工單轉出金額-制費四 */
xccf306h       number(20,6)      ,/* 工單轉出金額-制費五 */
xccf307       number(20,6)      ,/* 本期當站下線數量 */
xccf308       number(20,6)      ,/* 本期當站下線金額 */
xccf308a       number(20,6)      ,/* 本期當站下線金額-材料 */
xccf308b       number(20,6)      ,/* 本期當站下線金額-人工 */
xccf308c       number(20,6)      ,/* 本期當站下線金額-加工 */
xccf308d       number(20,6)      ,/* 本期當站下線金額-制費一 */
xccf308e       number(20,6)      ,/* 本期當站下線金額-制費二 */
xccf308f       number(20,6)      ,/* 本期當站下線金額-制費三 */
xccf308g       number(20,6)      ,/* 本期當站下線金額-制費四 */
xccf308h       number(20,6)      ,/* 本期當站下線金額-制費五 */
xccf309       number(20,6)      ,/* 本期重流數量 */
xccf310       number(20,6)      ,/* 本期重流金額 */
xccf310a       number(20,6)      ,/* 本期重流金額-材料 */
xccf310b       number(20,6)      ,/* 本期重流金額-人工 */
xccf310c       number(20,6)      ,/* 本期重流金額-加工 */
xccf310d       number(20,6)      ,/* 本期重流金額-制費一 */
xccf310e       number(20,6)      ,/* 本期重流金額-制費二 */
xccf310f       number(20,6)      ,/* 本期重流金額-制費三 */
xccf310g       number(20,6)      ,/* 本期重流金額-制費四 */
xccf310h       number(20,6)      ,/* 本期重流金額-制費五 */
xccf311       number(20,6)      ,/* 差異轉出數量 */
xccf312       number(20,6)      ,/* 差異轉出金額 */
xccf312a       number(20,6)      ,/* 差異轉出金額-材料 */
xccf312b       number(20,6)      ,/* 差異轉出金額-人工 */
xccf312c       number(20,6)      ,/* 差異轉出金額-加工 */
xccf312d       number(20,6)      ,/* 差異轉出金額-制費一 */
xccf312e       number(20,6)      ,/* 差異轉出金額-制費二 */
xccf312f       number(20,6)      ,/* 差異轉出金額-制費三 */
xccf312g       number(20,6)      ,/* 差異轉出金額-制費四 */
xccf312h       number(20,6)      ,/* 差異轉出金額-制費五 */
xccf313       number(20,6)      ,/* 本期超領退數量 */
xccf314       number(20,6)      ,/* 本期超領退金額 */
xccf314a       number(20,6)      ,/* 本期超領退金額-材料 */
xccf314b       number(20,6)      ,/* 本期超領退金額-人工 */
xccf314c       number(20,6)      ,/* 本期超領退金額-加工 */
xccf314d       number(20,6)      ,/* 本期超領退金額-制費一 */
xccf314e       number(20,6)      ,/* 本期超領退金額-制費二 */
xccf314f       number(20,6)      ,/* 本期超領退金額-制費三 */
xccf314g       number(20,6)      ,/* 本期超領退金額-制費四 */
xccf314h       number(20,6)      ,/* 本期超領退金額-制費五 */
xccf315       number(20,6)      ,/* 盤差數量 */
xccf316       number(20,6)      ,/* 盤差金額 */
xccf316a       number(20,6)      ,/* 盤差金額-材料 */
xccf316b       number(20,6)      ,/* 盤差金額-人工 */
xccf316c       number(20,6)      ,/* 盤差金額-加工 */
xccf316d       number(20,6)      ,/* 盤差金額-制費一 */
xccf316e       number(20,6)      ,/* 盤差金額-制費二 */
xccf316f       number(20,6)      ,/* 盤差金額-制費三 */
xccf316g       number(20,6)      ,/* 盤差金額-制費四 */
xccf316h       number(20,6)      ,/* 盤差金額-制費五 */
xccf901       number(20,6)      ,/* 期末結存數量 */
xccf902       number(20,6)      ,/* 期末結存金額 */
xccf902a       number(20,6)      ,/* 期末結存金額-材料 */
xccf902b       number(20,6)      ,/* 期末結存金額-人工 */
xccf902c       number(20,6)      ,/* 期末結存金額-加工 */
xccf902d       number(20,6)      ,/* 期末結存金額-制費一 */
xccf902e       number(20,6)      ,/* 期末結存金額-制費二 */
xccf902f       number(20,6)      ,/* 期末結存金額-制費三 */
xccf902g       number(20,6)      ,/* 期末結存金額-製費四 */
xccf902h       number(20,6)      /* 期末結存金額-制費五 */
);
alter table xccf_t add constraint xccf_pk primary key (xccfent,xccfld,xccf001,xccf002,xccf003,xccf004,xccf005,xccf006,xccf007,xccf008,xccf009,xccf010,xccf011,xccf012) enable validate;

create unique index xccf_pk on xccf_t (xccfent,xccfld,xccf001,xccf002,xccf003,xccf004,xccf005,xccf006,xccf007,xccf008,xccf009,xccf010,xccf011,xccf012);

grant select on xccf_t to tiptop;
grant update on xccf_t to tiptop;
grant delete on xccf_t to tiptop;
grant insert on xccf_t to tiptop;

exit;
