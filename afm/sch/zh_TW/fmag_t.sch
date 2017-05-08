/* 
================================================================================
檔案代號:fmag_t
檔案名稱:融資稽覈單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmag_t
(
fmagent       number(5)      ,/* 企業編號 */
fmagdocno       varchar2(20)      ,/* 融資申請稽覈單號 */
fmagsite       varchar2(10)      ,/* 資金中心 */
fmagdocdt       date      ,/* 日期 */
fmagownid       varchar2(20)      ,/* 資料所有者 */
fmagowndp       varchar2(10)      ,/* 資料所屬部門 */
fmagcrtid       varchar2(20)      ,/* 資料建立者 */
fmagcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmagcrtdt       timestamp(0)      ,/* 資料創建日 */
fmagmodid       varchar2(20)      ,/* 資料修改者 */
fmagmoddt       timestamp(0)      ,/* 最近修改日 */
fmagcnfid       varchar2(20)      ,/* 資料確認者 */
fmagcnfdt       timestamp(0)      ,/* 資料確認日 */
fmagstus       varchar2(10)      /* 狀態碼 */
);
alter table fmag_t add constraint fmag_pk primary key (fmagent,fmagdocno) enable validate;

create unique index fmag_pk on fmag_t (fmagent,fmagdocno);

grant select on fmag_t to tiptop;
grant update on fmag_t to tiptop;
grant delete on fmag_t to tiptop;
grant insert on fmag_t to tiptop;

exit;
