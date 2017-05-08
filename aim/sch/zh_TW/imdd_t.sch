/* 
================================================================================
檔案代號:imdd_t
檔案名稱:產品結構引入營運據點料件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imdd_t
(
imddent       number(5)      ,/* 企業代碼 */
imddstus       varchar2(10)      ,/* 狀態碼 */
imdd001       varchar2(10)      ,/* 營運據點 */
imdd002       varchar2(40)      ,/* 料件編號 */
imdd003       varchar2(10)      ,/* 引入方式 */
imddownid       varchar2(10)      ,/* 資料所有者 */
imddowndp       varchar2(10)      ,/* 資料所屬部門 */
imddcrtid       varchar2(10)      ,/* 資料建立者 */
imddcrtdt       date      ,/* 資料創建日 */
imddcrtdp       varchar2(10)      ,/* 資料建立部門 */
imddmodid       varchar2(10)      ,/* 資料修改者 */
imddmoddt       date      /* 最近修改日 */
);
alter table imdd_t add constraint imdd_pk primary key (imddent,imdd001,imdd002) enable validate;

create  index imdd_01 on imdd_t (imdd001,imdd002);

grant select on imdd_t to tiptop;
grant update on imdd_t to tiptop;
grant delete on imdd_t to tiptop;
grant insert on imdd_t to tiptop;

exit;
