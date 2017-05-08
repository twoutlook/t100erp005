/* 
================================================================================
檔案代號:indu_t
檔案名稱:供應商庫存批量轉移單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table indu_t
(
induent       number(5)      ,/* 企業編號 */
indusite       varchar2(10)      ,/* 營運組織 */
induunit       varchar2(10)      ,/* 應用組織 */
indudocno       varchar2(20)      ,/* 單據編號 */
indudocdt       date      ,/* 單據日期 */
indu001       varchar2(10)      ,/* 轉出供應商 */
indu002       varchar2(10)      ,/* 轉入供應商 */
indu003       varchar2(1)      ,/* 產生供應商往來金額調整 */
indu004       varchar2(10)      ,/* 轉移方法 */
indu005       number(20,6)      ,/* 轉移總數量 */
indu006       number(20,6)      ,/* 轉移總金額 */
indu007       varchar2(10)      ,/* 管理品類 */
indu008       varchar2(20)      ,/* 業務人員 */
indu009       varchar2(10)      ,/* 部門 */
indu010       varchar2(255)      ,/* 備註 */
industus       varchar2(10)      ,/* 狀態碼 */
induownid       varchar2(20)      ,/* 資料所有者 */
induowndp       varchar2(10)      ,/* 資料所屬部門 */
inducrtid       varchar2(20)      ,/* 資料建立者 */
inducrtdp       varchar2(10)      ,/* 資料建立部門 */
inducrtdt       timestamp(0)      ,/* 資料創建日 */
indumodid       varchar2(20)      ,/* 資料修改者 */
indumoddt       timestamp(0)      ,/* 最近修改日 */
inducnfid       varchar2(20)      ,/* 資料確認者 */
inducnfdt       timestamp(0)      /* 資料確認日 */
);
alter table indu_t add constraint indu_pk primary key (induent,indudocno) enable validate;

create unique index indu_pk on indu_t (induent,indudocno);

grant select on indu_t to tiptop;
grant update on indu_t to tiptop;
grant delete on indu_t to tiptop;
grant insert on indu_t to tiptop;

exit;
