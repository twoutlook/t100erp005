/* 
================================================================================
檔案代號:imegs_t
檔案名稱:規則化規格設定資料檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table imegs_t
(
imegsent       number(5)      ,/* 企業編號 */
imegs001       varchar2(10)      ,/* 規格種類 */
imegs003       varchar2(10)      ,/* 節點編號 */
imegs004       varchar2(40)      ,/* 提速值 */
imegs005       number(5,0)      /* 階層 */
);
alter table imegs_t add constraint imegs_pk primary key (imegsent,imegs001,imegs003,imegs004) enable validate;

create unique index imegs_pk on imegs_t (imegsent,imegs001,imegs003,imegs004);

grant select on imegs_t to tiptop;
grant update on imegs_t to tiptop;
grant delete on imegs_t to tiptop;
grant insert on imegs_t to tiptop;

exit;
