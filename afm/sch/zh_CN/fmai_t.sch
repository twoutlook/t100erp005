/* 
================================================================================
檔案代號:fmai_t
檔案名稱:融資審批清單檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmai_t
(
fmaient       number(5)      ,/* 企業編號 */
fmaidocno       varchar2(20)      ,/* 單據編號 */
fmaiseq       number(10,0)      ,/* 確認單項次 */
fmaiseq2       number(10,0)      ,/* 項次 */
fmai001       varchar2(10)      ,/* 申請組織 */
fmai002       varchar2(20)      ,/* 申請單編號 */
fmai003       number(10,0)      ,/* 申請單項次 */
fmai004       number(20,6)      /* 融資額度 */
);
alter table fmai_t add constraint fmai_pk primary key (fmaient,fmaidocno,fmaiseq,fmaiseq2) enable validate;

create unique index fmai_pk on fmai_t (fmaient,fmaidocno,fmaiseq,fmaiseq2);

grant select on fmai_t to tiptop;
grant update on fmai_t to tiptop;
grant delete on fmai_t to tiptop;
grant insert on fmai_t to tiptop;

exit;
