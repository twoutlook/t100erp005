/* 
================================================================================
檔案代號:inau_t
檔案名稱:製造批序號庫存期間/月統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table inau_t
(
inauent       number(5)      ,/* 企業編號 */
inausite       varchar2(10)      ,/* 營運據點 */
inau001       varchar2(40)      ,/* 料件編號 */
inau002       varchar2(256)      ,/* 產品特徵 */
inau003       varchar2(30)      ,/* 庫存管理特徵 */
inau004       varchar2(10)      ,/* 庫位編號 */
inau005       varchar2(10)      ,/* 儲位編號 */
inau006       varchar2(30)      ,/* 批號 */
inau007       varchar2(30)      ,/* 製造批號 */
inau008       varchar2(30)      ,/* 製造序號 */
inau009       varchar2(10)      ,/* 庫存單位 */
inau010       number(5,0)      ,/* 年度 */
inau011       number(5,0)      ,/* 期別 */
inau012       number(20,6)      ,/* 本期入庫統計量 */
inau013       number(20,6)      ,/* 本期銷貨統計量 */
inau014       number(20,6)      ,/* 本期領用統計量 */
inau015       number(20,6)      ,/* 本期轉撥統計量 */
inau016       number(20,6)      ,/* 本期調整統計量 */
inau017       number(20,6)      ,/* 期末數量 */
inau018       varchar2(256)      /* Tag二進位碼 */
);
alter table inau_t add constraint inau_pk primary key (inauent,inausite,inau001,inau002,inau003,inau004,inau005,inau006,inau007,inau008,inau009,inau010,inau011) enable validate;

create unique index inau_pk on inau_t (inauent,inausite,inau001,inau002,inau003,inau004,inau005,inau006,inau007,inau008,inau009,inau010,inau011);

grant select on inau_t to tiptop;
grant update on inau_t to tiptop;
grant delete on inau_t to tiptop;
grant insert on inau_t to tiptop;

exit;
