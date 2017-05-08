/* 
================================================================================
檔案代號:dzyf_t
檔案名稱:纪录程序已出货清单
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzyf_t
(
dzyf001       varchar2(20)      ,/* 程序编号 */
dzyf002       date      ,/* 纪录日期 */
dzyf003       number(10)      ,/* 建构版次 */
dzyf004       number(10)      ,/* 规格版次 */
dzyf005       number(10)      /* 程序版次 */
);
alter table dzyf_t add constraint dzyf_pk primary key (dzyf001) enable validate;

create unique index dzyf_pk on dzyf_t (dzyf001);

grant select on dzyf_t to tiptop;
grant update on dzyf_t to tiptop;
grant delete on dzyf_t to tiptop;
grant insert on dzyf_t to tiptop;

exit;
