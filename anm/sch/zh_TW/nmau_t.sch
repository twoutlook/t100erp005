/* 
================================================================================
檔案代號:nmau_t
檔案名稱:網銀資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmau_t
(
nmauent       number(5)      ,/* 企業編碼 */
nmau001       varchar2(15)      ,/* 網銀编码 */
nmau002       varchar2(1)      ,/* 交易類別 */
nmau003       varchar2(10)      ,/* 作業編號 */
nmaustus       varchar2(1)      ,/* 有效碼 */
nmauownid       varchar2(20)      ,/* 資料所有者 */
nmauowndp       varchar2(10)      ,/* 資料所屬部門 */
nmaucrtid       varchar2(20)      ,/* 資料建立者 */
nmaucrtdp       varchar2(10)      ,/* 資料建立部門 */
nmaucrtdt       timestamp(0)      ,/* 資料創建日 */
nmaumodid       varchar2(20)      ,/* 資料修改者 */
nmaumoddt       timestamp(0)      /* 最近修改日 */
);
alter table nmau_t add constraint nmau_pk primary key (nmauent,nmau001,nmau002) enable validate;

create unique index nmau_pk on nmau_t (nmauent,nmau001,nmau002);

grant select on nmau_t to tiptop;
grant update on nmau_t to tiptop;
grant delete on nmau_t to tiptop;
grant insert on nmau_t to tiptop;

exit;
