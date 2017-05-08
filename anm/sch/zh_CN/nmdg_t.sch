/* 
================================================================================
檔案代號:nmdg_t
檔案名稱:銀行對帳交易明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmdg_t
(
nmdgent       number(5)      ,/* 企業編碼 */
nmdgsite       varchar2(10)      ,/* 資金中心 */
nmdgcomf       varchar2(10)      ,/* 法人 */
nmdg001       varchar2(10)      ,/* 銀行交易帳戶 */
nmdg002       varchar2(20)      ,/* 企業流水號 */
nmdg003       date      ,/* 交易日期 */
nmdg004       varchar2(40)      ,/* 交易時間 */
nmdg005       varchar2(30)      ,/* 對方帳號 */
nmdg006       varchar2(80)      ,/* 對方帳戶名 */
nmdg007       varchar2(80)      ,/* 對方開戶行名 */
nmdg008       varchar2(1)      ,/* 借貸別 */
nmdg009       number(20,6)      ,/* 交易金額 */
nmdg010       number(20,6)      ,/* 交易餘額 */
nmdg011       varchar2(80)      ,/* 用途 */
nmdg012       varchar2(80)      ,/* 附言 */
nmdg013       varchar2(40)      ,/* 銀行單據號 */
nmdg014       varchar2(20)      ,/* ERP單據號 */
nmdg015       varchar2(10)      ,/* 交易對象編號 */
nmdg016       varchar2(20)      ,/* 交易對象識別碼 */
nmdg017       varchar2(1)      ,/* 對帳碼 */
nmdg018       varchar2(10)      ,/* 帳戶編碼 */
nmdg019       varchar2(20)      /* 對帳流水號 */
);
alter table nmdg_t add constraint nmdg_pk primary key (nmdgent,nmdg001,nmdg002,nmdg018) enable validate;

create unique index nmdg_pk on nmdg_t (nmdgent,nmdg001,nmdg002,nmdg018);

grant select on nmdg_t to tiptop;
grant update on nmdg_t to tiptop;
grant delete on nmdg_t to tiptop;
grant insert on nmdg_t to tiptop;

exit;
