/* 
================================================================================
檔案代號:sffe_t
檔案名稱:報工單作業人員明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sffe_t
(
sffeent       number(5)      ,/* 企業編號 */
sffesite       varchar2(10)      ,/* 營運據點 */
sffedocno       varchar2(20)      ,/* 報工單號 */
sffeseq       number(10,0)      ,/* 項次 */
sffe001       varchar2(20)      ,/* 作業人員 */
sffe002       number(15,3)      ,/* 工時 */
sffe003       number(15,3)      /* 數量 */
);
alter table sffe_t add constraint sffe_pk primary key (sffeent,sffedocno,sffeseq,sffe001) enable validate;

create unique index sffe_pk on sffe_t (sffeent,sffedocno,sffeseq,sffe001);

grant select on sffe_t to tiptop;
grant update on sffe_t to tiptop;
grant delete on sffe_t to tiptop;
grant insert on sffe_t to tiptop;

exit;
