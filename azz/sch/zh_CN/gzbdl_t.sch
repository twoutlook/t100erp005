/* 
================================================================================
檔案代號:gzbdl_t
檔案名稱:系統流程中可使用的節點代號多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzbdl_t
(
gzbdl001       varchar2(40)      ,/* 節點編號 */
gzbdl002       varchar2(6)      ,/* 語系 */
gzbdl003       varchar2(40)      ,/* 節點說明 */
gzbdlent       number(5)      /* 企業碼 */
);
alter table gzbdl_t add constraint gzbdl_pk primary key (gzbdl001,gzbdl002,gzbdlent) enable validate;

create unique index gzbdl_pk on gzbdl_t (gzbdl001,gzbdl002,gzbdlent);

grant select on gzbdl_t to tiptop;
grant update on gzbdl_t to tiptop;
grant delete on gzbdl_t to tiptop;
grant insert on gzbdl_t to tiptop;

exit;
