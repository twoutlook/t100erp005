/* 
================================================================================
檔案代號:nmdf_t
檔案名稱:銀行對帳單開張檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmdf_t
(
nmdfent       number(5)      ,/* 企業編碼 */
nmdfsite       varchar2(10)      ,/* 資金中心 */
nmdfcomf       varchar2(10)      ,/* 法人 */
nmdf001       number(5,0)      ,/* 年度 */
nmdf002       number(5,0)      ,/* 期別 */
nmdf003       varchar2(10)      ,/* 交易帳戶編號 */
nmdf004       varchar2(20)      ,/* 流水號 */
nmdf005       date      ,/* 交易日記帳日期 */
nmdf006       varchar2(1)      ,/* 類型 */
nmdf007       number(20,6)      ,/* 借方金額 */
nmdf008       number(20,6)      ,/* 貸方金額 */
nmdf009       varchar2(80)      ,/* 摘要 */
nmdfownid       varchar2(20)      ,/* 資料所有者 */
nmdfowndp       varchar2(10)      ,/* 資料所屬部門 */
nmdfcrtid       varchar2(20)      ,/* 資料建立者 */
nmdfcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmdfcrtdt       timestamp(0)      ,/* 資料創建日 */
nmdfmodid       varchar2(20)      ,/* 資料修改者 */
nmdfmoddt       timestamp(0)      ,/* 最近修改日 */
nmdfstus       varchar2(10)      ,/* 狀態碼 */
nmdf010       varchar2(1)      ,/* 對帳碼 */
nmdf011       varchar2(20)      ,/* 對帳流水號 */
nmdfseq       number(10,0)      ,/* 項次 */
nmdf012       varchar2(80)      ,/* 日記帳來源單號 */
nmdf013       number(10,0)      ,/* 日計算來源項次 */
nmdf014       varchar2(20)      /* 對帳單號 */
);
alter table nmdf_t add constraint nmdf_pk primary key (nmdfent,nmdf001,nmdf002,nmdf003,nmdfseq) enable validate;

create unique index nmdf_pk on nmdf_t (nmdfent,nmdf001,nmdf002,nmdf003,nmdfseq);

grant select on nmdf_t to tiptop;
grant update on nmdf_t to tiptop;
grant delete on nmdf_t to tiptop;
grant insert on nmdf_t to tiptop;

exit;
