/* 
================================================================================
檔案代號:glzx_t
檔案名稱:南京教育訓練使用表格2014
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glzx_t
(
glzxent       number(5)      ,/* 企業代碼 */
glzx001       varchar2(10)      ,/* 測試一 */
glzx002       varchar2(10)      ,/* 測試二 */
glzx003       varchar2(10)      ,/* 測試三 */
glzxownid       varchar2(10)      ,/* 資料所有者 */
glzxowndp       varchar2(10)      ,/* 資料所屬部門 */
glzxcrtid       varchar2(10)      ,/* 資料建立者 */
glzxcrtdp       varchar2(10)      ,/* 資料建立部門 */
glzxcrtdt       date      ,/* 資料創建日 */
glzxmodid       varchar2(10)      ,/* 資料修改者 */
glzxmoddt       date      ,/* 最近修改日 */
glzxstus       varchar2(10)      /* 狀態碼 */
);
alter table glzx_t add constraint glzx_pk primary key (glzxent,glzx001) enable validate;


grant select on glzx_t to tiptop;
grant update on glzx_t to tiptop;
grant delete on glzx_t to tiptop;
grant insert on glzx_t to tiptop;

exit;
