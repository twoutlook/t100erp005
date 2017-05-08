/* 
================================================================================
檔案代號:nmab_t
檔案名稱:銀行資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmab_t
(
nmabent       number(5)      ,/* 企業編號 */
nmabstus       varchar2(10)      ,/* 狀態碼 */
nmab001       varchar2(15)      ,/* 銀行網點編號 */
nmab002       varchar2(1)      ,/* 銀行類型 */
nmab003       varchar2(15)      ,/* SWIFT碼 */
nmab004       varchar2(10)      ,/* 銀行節假日表 */
nmab005       varchar2(40)      ,/* 聯絡人姓名 */
nmab006       varchar2(4000)      ,/* 聯絡地址 */
nmab007       varchar2(20)      ,/* 通訊方式 */
nmab008       varchar2(10)      ,/* 國家地區編號 */
nmab009       varchar2(40)      ,/* IBAN */
nmabownid       varchar2(20)      ,/* 資料所有者 */
nmabowndp       varchar2(10)      ,/* 資料所屬部門 */
nmabcrtid       varchar2(20)      ,/* 資料建立者 */
nmabcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmabcrtdt       timestamp(0)      ,/* 資料創建日 */
nmabmodid       varchar2(20)      ,/* 資料修改者 */
nmabmoddt       timestamp(0)      ,/* 最近修改日 */
nmab010       varchar2(15)      /* 銀行編號 */
);
alter table nmab_t add constraint nmab_pk primary key (nmabent,nmab001) enable validate;

create unique index nmab_pk on nmab_t (nmabent,nmab001);

grant select on nmab_t to tiptop;
grant update on nmab_t to tiptop;
grant delete on nmab_t to tiptop;
grant insert on nmab_t to tiptop;

exit;
