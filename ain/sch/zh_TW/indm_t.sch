/* 
================================================================================
檔案代號:indm_t
檔案名稱:退貨申請單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table indm_t
(
indment       number(5)      ,/* 企業代碼 */
indmsite       varchar2(10)      ,/* 營運據點 */
indmunit       varchar2(10)      ,/* 應用組織 */
indmdocno       varchar2(20)      ,/* 單據編號 */
indmdocdt       date      ,/* 單據日期 */
indmstus       varchar2(10)      ,/* 狀態碼 */
indm001       varchar2(20)      ,/* 申請人員 */
indm002       varchar2(10)      ,/* 申請部門 */
indm003       varchar2(10)      ,/* 核准組織 */
indm004       varchar2(20)      ,/* 核准人員 */
indm005       varchar2(10)      ,/* 核准部門 */
indm006       date      ,/* 退貨日期 */
indm007       date      ,/* 核准日期 */
indm008       varchar2(10)      ,/* 退貨類型 */
indm009       varchar2(10)      ,/* 理由碼 */
indm010       varchar2(255)      ,/* 備註 */
indmownid       varchar2(20)      ,/* 資料所有者 */
indmowndp       varchar2(10)      ,/* 資料所屬部門 */
indmcrtid       varchar2(20)      ,/* 資料建立者 */
indmcrtdp       varchar2(10)      ,/* 資料建立部門 */
indmcrtdt       timestamp(0)      ,/* 資料創建日 */
indmmodid       varchar2(20)      ,/* 資料修改者 */
indmmoddt       timestamp(0)      ,/* 最近修改日 */
indmcnfid       varchar2(20)      ,/* 資料確認者 */
indmcnfdt       timestamp(0)      ,/* 資料確認日 */
indm011       varchar2(10)      ,/* 來源類型 */
indm012       varchar2(20)      /* 來源單號 */
);
alter table indm_t add constraint indm_pk primary key (indment,indmdocno) enable validate;

create unique index indm_pk on indm_t (indment,indmdocno);

grant select on indm_t to tiptop;
grant update on indm_t to tiptop;
grant delete on indm_t to tiptop;
grant insert on indm_t to tiptop;

exit;
