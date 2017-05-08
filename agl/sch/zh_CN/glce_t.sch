/* 
================================================================================
檔案代號:glce_t
檔案名稱:總帳期末調匯單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glce_t
(
glceent       number(5)      ,/* 企業編碼 */
glcecomp       varchar2(10)      ,/* 法人 */
glceld       varchar2(5)      ,/* 帳套 */
glce001       number(5,0)      ,/* 年度 */
glce002       number(5,0)      ,/* 期別 */
glce003       varchar2(20)      ,/* 部門 */
glce004       varchar2(80)      ,/* 摘要 */
glce005       varchar2(20)      ,/* 憑證編號 */
glceownid       varchar2(20)      ,/* 資料所有者 */
glceowndp       varchar2(10)      ,/* 資料所屬部門 */
glcecrtid       varchar2(20)      ,/* 資料建立者 */
glcecrtdp       varchar2(10)      ,/* 資料建立部門 */
glcecrtdt       timestamp(0)      ,/* 資料創建日 */
glcemodid       varchar2(20)      ,/* 資料修改者 */
glcemoddt       timestamp(0)      ,/* 最近修改日 */
glcecnfid       varchar2(20)      ,/* 資料確認者 */
glcecnfdt       timestamp(0)      ,/* 資料確認日 */
glcestus       varchar2(10)      ,/* 狀態碼 */
glcedocno       varchar2(20)      ,/* 單據編號 */
glce006       varchar2(10)      /* 現金變動碼 */
);
alter table glce_t add constraint glce_pk primary key (glceent,glceld,glce001,glce002) enable validate;

create unique index glce_pk on glce_t (glceent,glceld,glce001,glce002);

grant select on glce_t to tiptop;
grant update on glce_t to tiptop;
grant delete on glce_t to tiptop;
grant insert on glce_t to tiptop;

exit;
