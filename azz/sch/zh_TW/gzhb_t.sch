/* 
================================================================================
檔案代號:gzhb_t
檔案名稱:GWC佈景樣板檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzhb_t
(
gzhb001       varchar2(40)      ,/* 佈景編號 */
gzhb002       varchar2(10)      ,/* 類別 */
gzhb003       varchar2(10)      ,/* Tag */
gzhb004       varchar2(20)      ,/* ID */
gzhb005       varchar2(40)      /* 檔名 */
);
alter table gzhb_t add constraint gzhb_pk primary key (gzhb001,gzhb002,gzhb003,gzhb004) enable validate;

create unique index gzhb_pk on gzhb_t (gzhb001,gzhb002,gzhb003,gzhb004);

grant select on gzhb_t to tiptop;
grant update on gzhb_t to tiptop;
grant delete on gzhb_t to tiptop;
grant insert on gzhb_t to tiptop;

exit;
