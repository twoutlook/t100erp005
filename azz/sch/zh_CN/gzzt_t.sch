/* 
================================================================================
檔案代號:gzzt_t
檔案名稱:模組可用表格代碼對照表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzt_t
(
gzzt001       varchar2(4)      ,/* 模組名稱 */
gzzt002       varchar2(15)      /* 表格允許字首 */
);
alter table gzzt_t add constraint gzzt_pk primary key (gzzt001,gzzt002) enable validate;

create unique index gzzt_pk on gzzt_t (gzzt001,gzzt002);

grant select on gzzt_t to tiptop;
grant update on gzzt_t to tiptop;
grant delete on gzzt_t to tiptop;
grant insert on gzzt_t to tiptop;

exit;
