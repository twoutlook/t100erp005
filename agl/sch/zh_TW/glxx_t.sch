/* 
================================================================================
檔案代號:glxx_t
檔案名稱:t
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glxx_t
(
glxxent       number(5)      ,/* 企業代碼 */
glxxownid       varchar2(10)      ,/* 資料所有者 */
glxxowndp       varchar2(10)      ,/* 資料所屬部門 */
glxxcrtid       varchar2(10)      ,/* 資料建立者 */
glxxcrtdp       varchar2(10)      ,/* 資料建立部門 */
glxxcrtdt       date      ,/* 資料創建日 */
glxxmodid       varchar2(10)      ,/* 資料修改者 */
glxxmoddt       date      ,/* 最近修改日 */
glxxstus       varchar2(10)      ,/* 狀態碼 */
glxx001       varchar2(1)      ,/* t */
glxx002       varchar2(1)      /* t */
);
alter table glxx_t add constraint glxx_pk primary key (glxxent) enable validate;


grant select on glxx_t to tiptop;
grant update on glxx_t to tiptop;
grant delete on glxx_t to tiptop;
grant insert on glxx_t to tiptop;

exit;
