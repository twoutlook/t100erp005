/* 
================================================================================
檔案代號:mhag_t
檔案名稱:離職人員基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mhag_t
(
mhagent       number(5)      ,/* 企業編號 */
mhagsite       varchar2(10)      ,/* 營運組織 */
mhagunit       varchar2(10)      ,/* 制定組織 */
mhag001       varchar2(20)      ,/* 人員編號 */
mhag002       varchar2(20)      ,/* 身份證號碼 */
mhag003       date      ,/* 離職日期 */
mhag004       varchar2(10)      ,/* 離職理由碼 */
mhag005       varchar2(1)      ,/* 未辦理離職手續 */
mhag006       varchar2(20)      ,/* 費用單單號 */
mhag007       varchar2(1)      ,/* 納入黑名單 */
mhag008       varchar2(10)      ,/* 黑名單理由碼 */
mhag009       varchar2(255)      ,/* 備註 */
mhagownid       varchar2(20)      ,/* 資料所有者 */
mhagowndp       varchar2(10)      ,/* 資料所屬部門 */
mhagcrtid       varchar2(20)      ,/* 資料建立者 */
mhagcrtdp       varchar2(10)      ,/* 資料建立部門 */
mhagcrtdt       timestamp(0)      ,/* 資料創建日 */
mhagmodid       varchar2(20)      ,/* 資料修改者 */
mhagmoddt       timestamp(0)      ,/* 最近修改日 */
mhagcnfid       varchar2(20)      ,/* 資料確認者 */
mhagcnfdt       timestamp(0)      ,/* 資料確認日 */
mhagstus       varchar2(10)      /* 狀態碼 */
);
alter table mhag_t add constraint mhag_pk primary key (mhagent,mhag001) enable validate;

create unique index mhag_pk on mhag_t (mhagent,mhag001);

grant select on mhag_t to tiptop;
grant update on mhag_t to tiptop;
grant delete on mhag_t to tiptop;
grant insert on mhag_t to tiptop;

exit;
