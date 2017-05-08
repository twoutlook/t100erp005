/* 
================================================================================
檔案代號:oodd
檔案名稱:交易分類稅別主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oodd
(
ooddent       number(5)      ,/* 企業代碼 */
ooddownid       varchar2(10)      ,/* 資料所有者 */
ooddowndp       varchar2(10)      ,/* 資料所屬部門 */
ooddcrtid       varchar2(10)      ,/* 資料建立者 */
ooddcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooddcrtdt       date      ,/* 資料創建日 */
ooddmodid       varchar2(10)      ,/* 資料修改者 */
ooddmoddt       date      ,/* 最近修改日 */
ooddstus       varchar2(10)      ,/* 狀態碼 */
oodd001       varchar2(10)      ,/* 交易稅區 */
oodd002       varchar2(1)      ,/* 交易類型 */
oodd003       varchar2(10)      ,/* 產品分類碼 */
oodd004       varchar2(40)      ,/* 料件代碼 */
oodd005       varchar2(10)      ,/* 交易對象代碼 */
oodd006       varchar2(10)      ,/* 客戶分類/供應商分類 */
oodd007       varchar2(10)      ,/* 銷售分類/採購分類 */
oodd008       varchar2(10)      /* 稅別代碼 */
);
alter table oodd add constraint oodd_pk primary key (ooddent,oodd001,oodd002) enable validate;


grant select on oodd to tiptop;
grant update on oodd to tiptop;
grant delete on oodd to tiptop;
grant insert on oodd to tiptop;

exit;
