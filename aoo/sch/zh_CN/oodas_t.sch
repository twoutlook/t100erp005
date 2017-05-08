/* 
================================================================================
檔案代號:oodas_t
檔案名稱:申報單位檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table oodas_t
(
oodasent       number(5)      ,/* 企業編號 */
oodas001       varchar2(10)      ,/* 稅區別 */
oodas002       varchar2(10)      ,/* 申報單位 */
oodas003       varchar2(40)      ,/* 提速值 */
oodas004       number(5,0)      /* 階層 */
);
alter table oodas_t add constraint oodas_pk primary key (oodasent,oodas001,oodas002,oodas003) enable validate;

create unique index oodas_pk on oodas_t (oodasent,oodas001,oodas002,oodas003);

grant select on oodas_t to tiptop;
grant update on oodas_t to tiptop;
grant delete on oodas_t to tiptop;
grant insert on oodas_t to tiptop;

exit;
