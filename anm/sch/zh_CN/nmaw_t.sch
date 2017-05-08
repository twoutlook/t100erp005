/* 
================================================================================
檔案代號:nmaw_t
檔案名稱:網銀人員帳號權限設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmaw_t
(
nmawent       number(5)      ,/* 企業編碼 */
nmaw001       varchar2(20)      ,/* 員工編號 */
nmaw002       varchar2(15)      ,/* 銀行編碼 */
nmaw003       varchar2(15)      ,/* 交易帳戶編碼 */
nmawstus       varchar2(1)      ,/* 有效碼 */
nmawownid       varchar2(20)      ,/* 資料所有者 */
nmawowndp       varchar2(10)      ,/* 資料所屬部門 */
nmawcrtid       varchar2(20)      ,/* 資料建立者 */
nmawcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmawcrtdt       timestamp(0)      ,/* 資料創建日 */
nmawmodid       varchar2(20)      ,/* 資料修改者 */
nmawmoddt       timestamp(0)      /* 最近修改日 */
);
alter table nmaw_t add constraint nmaw_pk primary key (nmawent,nmaw001,nmaw002,nmaw003) enable validate;

create unique index nmaw_pk on nmaw_t (nmawent,nmaw001,nmaw002,nmaw003);

grant select on nmaw_t to tiptop;
grant update on nmaw_t to tiptop;
grant delete on nmaw_t to tiptop;
grant insert on nmaw_t to tiptop;

exit;
