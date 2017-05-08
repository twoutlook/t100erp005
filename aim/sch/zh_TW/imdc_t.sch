/* 
================================================================================
檔案代號:imdc_t
檔案名稱:產品結構引入營運據點產品分類檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imdc_t
(
imdcent       number(5)      ,/* 企業代碼 */
imdcstus       varchar2(10)      ,/* 狀態碼 */
imdc001       varchar2(10)      ,/* 營運據點 */
imdc002       varchar2(10)      ,/* 產品分類 */
imdc003       varchar2(10)      ,/* 引入方式 */
imdcownid       varchar2(10)      ,/* 資料所有者 */
imdcowndp       varchar2(10)      ,/* 資料所屬部門 */
imdccrtid       varchar2(10)      ,/* 資料建立者 */
imdccrtdt       date      ,/* 資料創建日 */
imdccrtdp       varchar2(10)      ,/* 資料建立部門 */
imdcmodid       varchar2(10)      ,/* 資料修改者 */
imdcmoddt       date      /* 最近修改日 */
);
alter table imdc_t add constraint imdc_pk primary key (imdcent,imdc001,imdc002) enable validate;

create  index imdc_01 on imdc_t (imdc001,imdc002);

grant select on imdc_t to tiptop;
grant update on imdc_t to tiptop;
grant delete on imdc_t to tiptop;
grant insert on imdc_t to tiptop;

exit;
