/* 
================================================================================
檔案代號:infg_t
檔案名稱:商品上下架表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table infg_t
(
infgent       number(5)      ,/* 企業代碼 */
infgsite       varchar2(10)      ,/* 營運據點 */
infgunit       varchar2(10)      ,/* 應用組織 */
infgdocno       varchar2(20)      ,/* 單據編號 */
infgdocdt       date      ,/* 單據日期 */
infg001       varchar2(10)      ,/* 單據類型 */
infg002       varchar2(10)      ,/* 來源類型 */
infg003       varchar2(20)      ,/* 來源單號 */
infg004       varchar2(20)      ,/* 業務人員 */
infg005       varchar2(10)      ,/* 業務部門 */
infgstus       varchar2(10)      ,/* 狀態 */
infgownid       varchar2(20)      ,/* 資料所有者 */
infgowndp       varchar2(10)      ,/* 資料所屬部門 */
infgcrtid       varchar2(20)      ,/* 資料建立者 */
infgcrtdp       varchar2(10)      ,/* 資料建立部門 */
infgcrtdt       timestamp(0)      ,/* 資料創建日 */
infgmodid       varchar2(20)      ,/* 資料修改者 */
infgmoddt       timestamp(0)      ,/* 最近修改日 */
infgcnfid       varchar2(20)      ,/* 資料確認者 */
infgcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table infg_t add constraint infg_pk primary key (infgent,infgdocno) enable validate;

create unique index infg_pk on infg_t (infgent,infgdocno);

grant select on infg_t to tiptop;
grant update on infg_t to tiptop;
grant delete on infg_t to tiptop;
grant insert on infg_t to tiptop;

exit;
