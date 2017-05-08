/* 
================================================================================
檔案代號:mmdi_t
檔案名稱:規則對象範圍申請明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmdi_t
(
mmdient       number(5)      ,/* 企业代码 */
mmdisite       varchar2(10)      ,/* 营运组织 */
mmdiunit       varchar2(10)      ,/* 應用組織 */
mmdidocno       varchar2(30)      ,/* 單據編號 */
mmdi001       varchar2(30)      ,/* 活動規則 */
mmdi002       varchar2(10)      ,/* 規則對象 */
mmdi003       varchar2(10)      ,/* 規則對象編號 */
mmdiacti       varchar2(1)      /* 資料有效 */
);
alter table mmdi_t add constraint mmdi_pk primary key (mmdient,mmdidocno,mmdi003) enable validate;

create unique index mmdi_pk on mmdi_t (mmdient,mmdidocno,mmdi003);

grant select on mmdi_t to tiptop;
grant update on mmdi_t to tiptop;
grant delete on mmdi_t to tiptop;
grant insert on mmdi_t to tiptop;

exit;
