/* 
================================================================================
檔案代號:dzej_t
檔案名稱:共通代碼明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzej_t
(
dzejstus       varchar2(10)      ,/* 狀態碼 */
dzej001       varchar2(40)      ,/* 代碼代號 */
dzej002       varchar2(40)      ,/* 明細代號 */
dzej003       varchar2(80)      ,/* 明細名稱 */
dzej004       varchar2(500)      ,/* 用途描述 */
dzej005       varchar2(80)      ,/* 參數欄位1 */
dzej006       varchar2(80)      ,/* 參數欄位2 */
dzej007       varchar2(80)      ,/* 參數欄位3 */
dzej008       varchar2(80)      ,/* 參數欄位4 */
dzej009       varchar2(80)      ,/* 參數欄位5 */
dzejownid       varchar2(20)      ,/* 資料所有者 */
dzejowndp       varchar2(10)      ,/* 資料所屬部門 */
dzejcrtid       varchar2(20)      ,/* 資料建立者 */
dzejcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzejcrtdt       timestamp(0)      ,/* 資料創建日 */
dzejmodid       varchar2(20)      ,/* 資料修改者 */
dzejmoddt       timestamp(0)      ,/* 最近修改日 */
dzejcnfid       varchar2(20)      ,/* 資料確認者 */
dzejcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzej_t add constraint dzej_pk primary key (dzej001,dzej002) enable validate;

create unique index dzej_pk on dzej_t (dzej001,dzej002);

grant select on dzej_t to tiptop;
grant update on dzej_t to tiptop;
grant delete on dzej_t to tiptop;
grant insert on dzej_t to tiptop;

exit;
