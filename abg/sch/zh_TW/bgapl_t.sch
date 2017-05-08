/* 
================================================================================
檔案代號:bgapl_t
檔案名稱:预算交易对象对应档多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgapl_t
(
bgaplent       number(5)      ,/* 企业编号 */
bgapl001       varchar2(10)      ,/* 预算交易对象 */
bgapl002       varchar2(6)      ,/* 语言别 */
bgapl003       varchar2(255)      ,/* 预算交易对象全名 */
bgapl004       varchar2(10)      ,/* 助记码 */
bgapl005       varchar2(80)      /* 预算交易对象简称 */
);
alter table bgapl_t add constraint bgapl_pk primary key (bgaplent,bgapl001,bgapl002) enable validate;

create unique index bgapl_pk on bgapl_t (bgaplent,bgapl001,bgapl002);

grant select on bgapl_t to tiptop;
grant update on bgapl_t to tiptop;
grant delete on bgapl_t to tiptop;
grant insert on bgapl_t to tiptop;

exit;
