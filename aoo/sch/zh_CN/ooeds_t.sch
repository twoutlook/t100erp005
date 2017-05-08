/* 
================================================================================
檔案代號:ooeds_t
檔案名稱:組織結構提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table ooeds_t
(
ooedsent       number(5)      ,/* 企業編號 */
ooeds001       varchar2(1)      ,/* 組織類型 */
ooeds002       varchar2(10)      ,/* 組織編號 */
ooeds003       varchar2(10)      ,/* 提速值 */
ooeds004       number(5,0)      /* 階層 */
);
alter table ooeds_t add constraint ooeds_pk primary key (ooedsent,ooeds001,ooeds002,ooeds003) enable validate;

create unique index ooeds_pk on ooeds_t (ooedsent,ooeds001,ooeds002,ooeds003);

grant select on ooeds_t to tiptop;
grant update on ooeds_t to tiptop;
grant delete on ooeds_t to tiptop;
grant insert on ooeds_t to tiptop;

exit;
