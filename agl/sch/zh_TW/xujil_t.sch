/* 
================================================================================
檔案代號:xujil_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xujil_t
(
xujilent       number(5)      ,/* 企業代碼 */
xujilmodu       varchar2(10)      ,/* 資料修改者 */
xujildate       date      ,/* 最近修改日 */
xujiloriu       varchar2(10)      ,/* 資料所有者 */
xujilorid       varchar2(10)      ,/* 資料所有部門 */
xujiluser       varchar2(10)      ,/* 資料建立者 */
xujildept       varchar2(10)      ,/* 資料建立部門 */
xujilbuid       date      ,/* 資料創建日 */
xujilstus       varchar2(1)      ,/* 狀態碼 */
xujil001       varchar2(10)      ,/* 幣別編號 */
xujil002       number(5,0)      ,/* 語言別 */
xujil003       varchar2(80)      ,/* 說明 */
xujil004       varchar2(10)      /* 助記碼 */
);
alter table xujil_t add constraint xujil_pk primary key (xujilent,xujil001,xujil002) enable validate;

create  index xujil_01 on xujil_t (xujil004);

grant select on xujil_t to tiptop;
grant update on xujil_t to tiptop;
grant delete on xujil_t to tiptop;
grant insert on xujil_t to tiptop;

exit;
