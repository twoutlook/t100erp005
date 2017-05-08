/* 
================================================================================
檔案代號:glfcl_t
檔案名稱:公式設定檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glfcl_t
(
glfclent       number(5)      ,/* 企業編號 */
glfcl001       varchar2(10)      ,/* 公式編號 */
glfcl002       varchar2(6)      ,/* 語言別 */
glfcl003       varchar2(500)      ,/* 說明 */
glfcl004       varchar2(10)      /* 助記碼 */
);
alter table glfcl_t add constraint glfcl_pk primary key (glfclent,glfcl001,glfcl002) enable validate;

create unique index glfcl_pk on glfcl_t (glfclent,glfcl001,glfcl002);

grant select on glfcl_t to tiptop;
grant update on glfcl_t to tiptop;
grant delete on glfcl_t to tiptop;
grant insert on glfcl_t to tiptop;

exit;
