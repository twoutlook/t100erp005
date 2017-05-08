/* 
================================================================================
檔案代號:rpzz_t
檔案名稱:APP基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rpzz_t
(
rpzzownid       varchar2(20)      ,/* 資料所有者 */
rpzzowndp       varchar2(10)      ,/* 資料所屬部門 */
rpzzcrtid       varchar2(20)      ,/* 資料建立者 */
rpzzcrtdp       varchar2(10)      ,/* 資料建立部門 */
rpzzcrtdt       timestamp(0)      ,/* 資料創建日 */
rpzzmodid       varchar2(20)      ,/* 資料修改者 */
rpzzmoddt       timestamp(0)      ,/* 最近修改日 */
rpzzstus       varchar2(10)      ,/* 狀態碼 */
rpzz001       varchar2(20)      ,/* APP編號 */
rpzz002       varchar2(1)      ,/* 客製 */
rpzz003       varchar2(40)      ,/* 開發Project名稱 */
rpzz004       varchar2(4)      ,/* 歸屬模組 */
rpzz005       varchar2(80)      ,/* 歸屬行業別 */
rpzz006       varchar2(1)      /* 目錄選單類型 */
);
alter table rpzz_t add constraint rpzz_pk primary key (rpzz001) enable validate;

create unique index rpzz_pk on rpzz_t (rpzz001);

grant select on rpzz_t to tiptop;
grant update on rpzz_t to tiptop;
grant delete on rpzz_t to tiptop;
grant insert on rpzz_t to tiptop;

exit;
