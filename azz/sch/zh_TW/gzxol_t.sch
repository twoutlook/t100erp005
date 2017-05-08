/* 
================================================================================
檔案代號:gzxol_t
檔案名稱:查詢方案群組多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzxol_t
(
gzxolent       number(5)      ,/* 企業編號 */
gzxol001       number(10,0)      ,/* 群組編號 */
gzxol002       varchar2(20)      ,/* 作業編號 */
gzxol003       varchar2(20)      ,/* 員工編號 */
gzxol004       varchar2(6)      ,/* 語言別 */
gzxol005       varchar2(500)      ,/* 說明 */
gzxol006       varchar2(10)      /* 註記碼 */
);
alter table gzxol_t add constraint gzxol_pk primary key (gzxolent,gzxol001,gzxol002,gzxol003,gzxol004) enable validate;

create unique index gzxol_pk on gzxol_t (gzxolent,gzxol001,gzxol002,gzxol003,gzxol004);

grant select on gzxol_t to tiptop;
grant update on gzxol_t to tiptop;
grant delete on gzxol_t to tiptop;
grant insert on gzxol_t to tiptop;

exit;
