/* 
================================================================================
檔案代號:xcan_t
檔案名稱:成本差異科目設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xcan_t
(
xcanent       number(5)      ,/* 企業代碼 */
xcanld       varchar2(5)      ,/* 帳別 */
xcan001       varchar2(80)      ,/* 差異科目分類 */
xcan002       varchar2(24)      ,/* 科目編號 */
xcan003       varchar2(80)      ,/* 分攤公式類型 */
xcan004       varchar2(1)      ,/* 數據來源 */
xcan005       number(20,6)      ,/* 分攤比例% */
xcanownid       varchar2(20)      ,/* 資料所有者 */
xcanowndp       varchar2(10)      ,/* 資料所屬部門 */
xcancrtid       varchar2(20)      ,/* 資料建立者 */
xcancrtdp       varchar2(10)      ,/* 資料建立部門 */
xcancrtdt       timestamp(0)      ,/* 資料創建日 */
xcanmodid       varchar2(20)      ,/* 資料修改者 */
xcanmoddt       timestamp(0)      ,/* 最近修改日 */
xcancnfid       varchar2(20)      ,/* 資料確認者 */
xcancnfdt       timestamp(0)      ,/* 資料確認日 */
xcanstus       varchar2(10)      /* 狀態碼 */
);
alter table xcan_t add constraint xcan_pk primary key (xcanent,xcanld,xcan001,xcan002) enable validate;

create unique index xcan_pk on xcan_t (xcanent,xcanld,xcan001,xcan002);

grant select on xcan_t to tiptop;
grant update on xcan_t to tiptop;
grant delete on xcan_t to tiptop;
grant insert on xcan_t to tiptop;

exit;
