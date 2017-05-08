/* 
================================================================================
檔案代號:glfbl_t
檔案名稱:表報設定單身檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glfbl_t
(
glfblent       number(5)      ,/* 企業編號 */
glfbl001       varchar2(10)      ,/* 報表模板編號 */
glfblseq       number(10,0)      ,/* 行次 */
glfbl002       varchar2(10)      ,/* 報表項目編號 */
glfbl003       varchar2(6)      ,/* 語言別 */
glfbl004       varchar2(500)      ,/* 說明 */
glfbl005       varchar2(10)      /* 助記碼 */
);
alter table glfbl_t add constraint glfbl_pk primary key (glfblent,glfbl001,glfblseq,glfbl002,glfbl003) enable validate;

create unique index glfbl_pk on glfbl_t (glfblent,glfbl001,glfblseq,glfbl002,glfbl003);

grant select on glfbl_t to tiptop;
grant update on glfbl_t to tiptop;
grant delete on glfbl_t to tiptop;
grant insert on glfbl_t to tiptop;

exit;
