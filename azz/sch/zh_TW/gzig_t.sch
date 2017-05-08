/* 
================================================================================
檔案代號:gzig_t
檔案名稱:自定義查詢-使用資料表暫存檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzig_t
(
gzig001       varchar2(20)      ,/* 查詢單ID */
gzig002       varchar2(15)      ,/* 使用資料表名稱 */
gzig003       varchar2(15)      /* 使用資料表別名 */
);
alter table gzig_t add constraint gzig_pk primary key (gzig001,gzig002,gzig003) enable validate;

create unique index gzig_pk on gzig_t (gzig001,gzig002,gzig003);

grant select on gzig_t to tiptop;
grant update on gzig_t to tiptop;
grant delete on gzig_t to tiptop;
grant insert on gzig_t to tiptop;

exit;
