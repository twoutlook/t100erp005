/* 
================================================================================
檔案代號:gzie_t
檔案名稱:自定義查詢-參數明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzie_t
(
gzie001       varchar2(20)      ,/* 查詢單ID */
gzie002       number(5,0)      ,/* 序號 */
gzie003       varchar2(60)      ,/* 參數代號 */
gzie004       varchar2(20)      ,/* 參數型態參考欄位 */
gzie005       varchar2(80)      /* 參數說明 */
);
alter table gzie_t add constraint gzie_pk primary key (gzie001,gzie002) enable validate;

create unique index gzie_pk on gzie_t (gzie001,gzie002);

grant select on gzie_t to tiptop;
grant update on gzie_t to tiptop;
grant delete on gzie_t to tiptop;
grant insert on gzie_t to tiptop;

exit;
