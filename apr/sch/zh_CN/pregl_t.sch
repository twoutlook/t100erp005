/* 
================================================================================
檔案代號:pregl_t
檔案名稱:促銷談判結果單頭資料表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pregl_t
(
preglent       number(5)      ,/* 企業編號 */
pregl001       varchar2(20)      ,/* 規則編號 */
pregl002       varchar2(6)      ,/* 語言別 */
pregl003       varchar2(500)      ,/* 說明 */
pregl004       varchar2(10)      /* 助記碼 */
);
alter table pregl_t add constraint pregl_pk primary key (preglent,pregl001,pregl002) enable validate;

create unique index pregl_pk on pregl_t (preglent,pregl001,pregl002);

grant select on pregl_t to tiptop;
grant update on pregl_t to tiptop;
grant delete on pregl_t to tiptop;
grant insert on pregl_t to tiptop;

exit;
