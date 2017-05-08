/* 
================================================================================
檔案代號:inbk_t
檔案名稱:庫存有效日期變更單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inbk_t
(
inbkent       number(5)      ,/* 企業編號 */
inbksite       varchar2(10)      ,/* 營運據點 */
inbkdocno       varchar2(20)      ,/* 變更單號 */
inbkocdt       date      ,/* 變更日期 */
inbk001       varchar2(20)      ,/* 申請人員 */
inbk002       varchar2(10)      ,/* 申請部門 */
inbk005       varchar2(10)      ,/* 原因碼 */
inbk006       varchar2(255)      ,/* 備註 */
inbk007       varchar2(10)      ,/* 變更類型 */
inbkstus       varchar2(10)      ,/* 狀態碼 */
inbkownid       varchar2(20)      ,/* 資料所有者 */
inbkowndp       varchar2(10)      ,/* 資料所屬部門 */
inbkcrtid       varchar2(20)      ,/* 資料建立者 */
inbkcrtdp       varchar2(10)      ,/* 資料建立部門 */
inbkcrtdt       timestamp(0)      ,/* 資料創建日 */
inbkmodid       varchar2(20)      ,/* 資料修改者 */
inbkmoddt       timestamp(0)      ,/* 最近修改日 */
inbkcnfid       varchar2(20)      ,/* 資料確認者 */
inbkcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table inbk_t add constraint inbk_pk primary key (inbkent,inbkdocno) enable validate;

create unique index inbk_pk on inbk_t (inbkent,inbkdocno);

grant select on inbk_t to tiptop;
grant update on inbk_t to tiptop;
grant delete on inbk_t to tiptop;
grant insert on inbk_t to tiptop;

exit;
