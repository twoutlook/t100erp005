/* 
================================================================================
檔案代號:glacs_t
檔案名稱:會計科目資料檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table glacs_t
(
glacsent       number(5)      ,/* 企業編號 */
glacs001       varchar2(5)      ,/* 會計科目參照表號 */
glacs002       varchar2(24)      ,/* 會計科目編號 */
glacs003       varchar2(40)      ,/* 提速值 */
glacs004       number(5,0)      /* 階層 */
);
alter table glacs_t add constraint glacs_pk primary key (glacsent,glacs001,glacs002,glacs003) enable validate;

create  index glacs_01 on glacs_t (glacsent,glacs001,glacs003,glacs004);
create  index glacs_02 on glacs_t (glacsent,glacs001,glacs002);
create unique index glacs_pk on glacs_t (glacsent,glacs001,glacs002,glacs003);

grant select on glacs_t to tiptop;
grant update on glacs_t to tiptop;
grant delete on glacs_t to tiptop;
grant insert on glacs_t to tiptop;

exit;
