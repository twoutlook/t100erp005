/* 
================================================================================
檔案代號:glzxs_t
檔案名稱:南京教育訓練使用表格2014提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table glzxs_t
(
glzxsent       number(5)      ,/* 企業代碼 */
glzxs001       varchar2(10)      ,/* 測試一 */
glzxs002       varchar2(40)      ,/* 提速值 */
glzxs003       number(5,0)      /* 階層 */
);
alter table glzxs_t add constraint glzxs_pk primary key (glzxsent,glzxs001,glzxs002) enable validate;


grant select on glzxs_t to tiptop;
grant update on glzxs_t to tiptop;
grant delete on glzxs_t to tiptop;
grant insert on glzxs_t to tiptop;

exit;
