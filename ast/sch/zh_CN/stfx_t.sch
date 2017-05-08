/* 
================================================================================
檔案代號:stfx_t
檔案名稱:合同进项税变更单头表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table stfx_t
(
stfxent       number(5)      ,/* 企業代碼 */
stfxsite       varchar2(10)      ,/* 營運據點 */
stfxunit       varchar2(10)      ,/* 應用執行組織物件 */
stfxdocno       varchar2(20)      ,/* 單據編號 */
stfxdocdt       date      ,/* 單據日期 */
stfx001       varchar2(20)      ,/* 合約編號 */
stfx002       varchar2(10)      ,/* 版本 */
stfx003       varchar2(10)      ,/* 供應商編號 */
stfx004       varchar2(10)      ,/* 經營方式 */
stfx005       varchar2(10)      ,/* 合同狀態 */
stfx006       varchar2(40)      ,/* 文檔編號 */
stfx007       varchar2(10)      ,/* 原稅別 */
stfx008       varchar2(10)      ,/* 新稅別 */
stfx009       varchar2(2)      ,/* 原發票類型 */
stfx010       varchar2(2)      ,/* 新發票類型 */
stfx011       varchar2(1)      ,/* 原含發票否 */
stfx012       varchar2(1)      ,/* 新含發票否 */
stfx013       varchar2(255)      ,/* 備註 */
stfxownid       varchar2(20)      ,/* 資料所有者 */
stfxowndp       varchar2(10)      ,/* 資料所屬部門 */
stfxcrtid       varchar2(20)      ,/* 資料建立者 */
stfxcrtdp       varchar2(10)      ,/* 資料建立部門 */
stfxcrtdt       timestamp(0)      ,/* 資料創建日 */
stfxmodid       varchar2(20)      ,/* 資料修改者 */
stfxmoddt       timestamp(0)      ,/* 最近修改日 */
stfxcnfid       varchar2(20)      ,/* 資料確認者 */
stfxcnfdt       timestamp(0)      ,/* 資料確認日 */
stfxstus       varchar2(10)      /* 狀態碼 */
);
alter table stfx_t add constraint stfx_pk primary key (stfxent,stfxdocno) enable validate;

create unique index stfx_pk on stfx_t (stfxent,stfxdocno);

grant select on stfx_t to tiptop;
grant update on stfx_t to tiptop;
grant delete on stfx_t to tiptop;
grant insert on stfx_t to tiptop;

exit;
