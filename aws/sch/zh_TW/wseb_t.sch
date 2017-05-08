/* 
================================================================================
檔案代號:wseb_t
檔案名稱:中間庫SQL記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wseb_t
(
wseb001       varchar2(10)      ,/* 產品別 */
wseb002       varchar2(80)      ,/* 查詢代號 */
wseb003       varchar2(100)      ,/* 前置處理代號 */
wseb004       varchar2(2000)      ,/* SQL內容 */
wsebstus       varchar2(10)      ,/* 狀態碼 */
wsebownid       varchar2(20)      ,/* 資料所有者 */
wsebowndp       varchar2(10)      ,/* 資料所屬部門 */
wsebcrtid       varchar2(20)      ,/* 資料建立者 */
wsebcrtdp       varchar2(10)      ,/* 資料建立部門 */
wsebcrtdt       timestamp(0)      ,/* 資料創建日 */
wsebmodid       varchar2(20)      ,/* 資料修改者 */
wsebmoddt       timestamp(0)      /* 最近修改日 */
);
alter table wseb_t add constraint wseb_pk primary key (wseb001,wseb002) enable validate;

create unique index wseb_pk on wseb_t (wseb001,wseb002);

grant select on wseb_t to tiptop;
grant update on wseb_t to tiptop;
grant delete on wseb_t to tiptop;
grant insert on wseb_t to tiptop;

exit;
