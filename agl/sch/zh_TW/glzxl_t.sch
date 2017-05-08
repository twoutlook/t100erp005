/* 
================================================================================
檔案代號:glzxl_t
檔案名稱:南京教育訓練使用表格2014多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glzxl_t
(
glzxlent       number(5)      ,/* 企業代碼 */
glzxl001       varchar2(10)      ,/* 測試一 */
glzxl002       varchar2(6)      ,/* 語言別 */
glzxl003       varchar2(500)      ,/* 說明 */
glzxl004       varchar2(10)      /* 助記碼 */
);
alter table glzxl_t add constraint glzxl_pk primary key (glzxlent,glzxl001,glzxl002) enable validate;


grant select on glzxl_t to tiptop;
grant update on glzxl_t to tiptop;
grant delete on glzxl_t to tiptop;
grant insert on glzxl_t to tiptop;

exit;
