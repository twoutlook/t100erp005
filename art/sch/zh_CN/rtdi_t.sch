/* 
================================================================================
檔案代號:rtdi_t
檔案名稱:供應商清退表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtdi_t
(
rtdient       number(5)      ,/* 企業編號 */
rtdisite       varchar2(10)      ,/* 營運據點 */
rtdiunit       varchar2(10)      ,/* 應用組織 */
rtdidocno       varchar2(20)      ,/* 單據編號 */
rtdidocdt       date      ,/* 單據日期 */
rtdi001       varchar2(10)      ,/* 供應商編號 */
rtdi002       varchar2(10)      ,/* 清退原因 */
rtdi003       varchar2(20)      ,/* 申請人員 */
rtdi004       varchar2(10)      ,/* 申請部門 */
rtdi005       varchar2(10)      ,/* 供應商生命週期 */
rtdi006       varchar2(10)      ,/* 商品生命週期 */
rtdi007       varchar2(1)      ,/* 終止合同 */
rtdi008       varchar2(1)      ,/* 退庫存商品 */
rtdi009       number(20,6)      ,/* 庫存總額 */
rtdi010       number(20,6)      ,/* 未結算金額 */
rtdistus       varchar2(10)      ,/* 狀態 */
rtdiownid       varchar2(20)      ,/* 資料所有者 */
rtdiowndp       varchar2(10)      ,/* 資料所屬部門 */
rtdicrtid       varchar2(20)      ,/* 資料建立者 */
rtdicrtdp       varchar2(10)      ,/* 資料建立部門 */
rtdicrtdt       timestamp(0)      ,/* 資料創建日 */
rtdimodid       varchar2(20)      ,/* 資料修改者 */
rtdimoddt       timestamp(0)      ,/* 最近修改日 */
rtdicnfid       varchar2(20)      ,/* 資料確認者 */
rtdicnfdt       timestamp(0)      /* 資料確認日 */
);
alter table rtdi_t add constraint rtdi_pk primary key (rtdient,rtdidocno) enable validate;

create unique index rtdi_pk on rtdi_t (rtdient,rtdidocno);

grant select on rtdi_t to tiptop;
grant update on rtdi_t to tiptop;
grant delete on rtdi_t to tiptop;
grant insert on rtdi_t to tiptop;

exit;
