/* 
================================================================================
檔案代號:bgasl_t
檔案名稱:预算料件主档多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgasl_t
(
bgaslent       number(5)      ,/* 企业编号 */
bgasl001       varchar2(40)      ,/* 预算料号 */
bgasl002       varchar2(6)      ,/* 语言别 */
bgasl003       varchar2(255)      ,/* 品名 */
bgasl004       varchar2(255)      ,/* 规格 */
bgasl005       varchar2(10)      /* 助记码 */
);
alter table bgasl_t add constraint bgasl_pk primary key (bgaslent,bgasl001,bgasl002) enable validate;

create unique index bgasl_pk on bgasl_t (bgaslent,bgasl001,bgasl002);

grant select on bgasl_t to tiptop;
grant update on bgasl_t to tiptop;
grant delete on bgasl_t to tiptop;
grant insert on bgasl_t to tiptop;

exit;
