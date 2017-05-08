/* 
================================================================================
檔案代號:oojds_t
檔案名稱:渠道基本資料檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table oojds_t
(
oojdsent       number(5)      ,/* 企業編號 */
oojds001       varchar2(10)      ,/* 渠道編號 */
oojds002       varchar2(40)      ,/* 提速值 */
oojds003       number(5,0)      /* 階層 */
);
alter table oojds_t add constraint oojds_pk primary key (oojdsent,oojds001,oojds002) enable validate;

create unique index oojds_pk on oojds_t (oojdsent,oojds001,oojds002);

grant select on oojds_t to tiptop;
grant update on oojds_t to tiptop;
grant delete on oojds_t to tiptop;
grant insert on oojds_t to tiptop;

exit;
