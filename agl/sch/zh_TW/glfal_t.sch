/* 
================================================================================
檔案代號:glfal_t
檔案名稱:報表設定單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glfal_t
(
glfalent       number(5)      ,/* 企業編號 */
glfal001       varchar2(10)      ,/* 報表模板編號 */
glfal002       varchar2(6)      ,/* 語言別 */
glfal003       varchar2(500)      ,/* 說明 */
glfal004       varchar2(10)      /* 助記碼 */
);
alter table glfal_t add constraint glfal_pk primary key (glfalent,glfal001,glfal002) enable validate;

create unique index glfal_pk on glfal_t (glfalent,glfal001,glfal002);

grant select on glfal_t to tiptop;
grant update on glfal_t to tiptop;
grant delete on glfal_t to tiptop;
grant insert on glfal_t to tiptop;

exit;
