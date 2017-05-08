/* 
================================================================================
檔案代號:oofgs_t
檔案名稱:自動編碼設定資料提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table oofgs_t
(
oofgsent       number(5)      ,/* 企業編號 */
oofgs001       varchar2(10)      ,/* 編碼分類 */
oofgs002       varchar2(10)      ,/* 節點編號 */
oofgs003       varchar2(40)      ,/* 提速值 */
oofgs004       number(5,0)      /* 階層 */
);
alter table oofgs_t add constraint oofgs_pk primary key (oofgsent,oofgs001,oofgs002,oofgs003) enable validate;

create  index oofgs_01 on oofgs_t (oofgsent,oofgs001,oofgs003,oofgs004);
create  index oofgs_02 on oofgs_t (oofgsent,oofgs001,oofgs002);
create unique index oofgs_pk on oofgs_t (oofgsent,oofgs001,oofgs002,oofgs003);

grant select on oofgs_t to tiptop;
grant update on oofgs_t to tiptop;
grant delete on oofgs_t to tiptop;
grant insert on oofgs_t to tiptop;

exit;
