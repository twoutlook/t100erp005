/* 
================================================================================
檔案代號:gzwes_t
檔案名稱:選單設定表提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table gzwes_t
(
gzwes001       varchar2(20)      ,/* 上階目錄編號 */
gzwes002       varchar2(20)      ,/* 目錄編號 */
gzwes003       varchar2(40)      ,/* 提速值 */
gzwes004       number(5,0)      ,/* 階層 */
gzwesent       number(5)      /* 企業編號 */
);
alter table gzwes_t add constraint gzwes_pk primary key (gzwes001,gzwes002,gzwes003,gzwesent) enable validate;

create unique index gzwes_pk on gzwes_t (gzwes001,gzwes002,gzwes003,gzwesent);

grant select on gzwes_t to tiptop;
grant update on gzwes_t to tiptop;
grant delete on gzwes_t to tiptop;
grant insert on gzwes_t to tiptop;

exit;
