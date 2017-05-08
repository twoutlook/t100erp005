/* 
================================================================================
檔案代號:oocqs_t
檔案名稱:應用分類碼提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table oocqs_t
(
oocqsent       number(5)      ,/* 企業編號 */
oocqs001       number(5)      ,/* 應用分類 */
oocqs002       varchar2(10)      ,/* 應用分類碼 */
oocqs003       varchar2(10)      ,/* 提速值 */
oocqs004       number(5,0)      /* 階層 */
);
alter table oocqs_t add constraint oocqs_pk primary key (oocqsent,oocqs001,oocqs002,oocqs003) enable validate;

create unique index oocqs_pk on oocqs_t (oocqsent,oocqs001,oocqs002,oocqs003);

grant select on oocqs_t to tiptop;
grant update on oocqs_t to tiptop;
grant delete on oocqs_t to tiptop;
grant insert on oocqs_t to tiptop;

exit;
