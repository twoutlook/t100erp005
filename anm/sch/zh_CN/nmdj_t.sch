/* 
================================================================================
檔案代號:nmdj_t
檔案名稱:對帳作業單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table nmdj_t
(
nmdjent       number(5)      ,/* 企業編號 */
nmdjcomp       varchar2(10)      ,/* 法人 */
nmdjsite       varchar2(10)      ,/* 資金中心 */
nmdjdocno       varchar2(20)      ,/* 對帳單號 */
nmdj001       varchar2(10)      ,/* 銀行帳戶 */
nmdj002       number(5,0)      ,/* 年度 */
nmdj003       number(5,0)      ,/* 期別 */
nmdj004       date      ,/* 對帳日期 */
nmdj005       varchar2(20)      ,/* 對帳人員 */
nmdjownid       varchar2(20)      ,/* 資料所有者 */
nmdjowndp       varchar2(10)      ,/* 資料所屬部門 */
nmdjcrtid       varchar2(20)      ,/* 資料建立者 */
nmdjcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmdjcrtdt       timestamp(0)      ,/* 資料創建日 */
nmdjmodid       varchar2(20)      ,/* 資料修改者 */
nmdjmoddt       timestamp(0)      ,/* 最近修改日 */
nmdjcnfid       varchar2(20)      ,/* 資料確認者 */
nmdjcnfdt       timestamp(0)      ,/* 資料確認日 */
nmdjstus       varchar2(10)      /* 狀態碼 */
);
alter table nmdj_t add constraint nmdj_pk primary key (nmdjent,nmdjdocno) enable validate;

create unique index nmdj_pk on nmdj_t (nmdjent,nmdjdocno);

grant select on nmdj_t to tiptop;
grant update on nmdj_t to tiptop;
grant delete on nmdj_t to tiptop;
grant insert on nmdj_t to tiptop;

exit;
