/* 
================================================================================
檔案代號:fmbg_t
檔案名稱:融資確認檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmbg_t
(
fmbgent       number(5)      ,/* 企業編號 */
fmbg001       varchar2(20)      ,/* 融資確認單號 */
fmbg002       varchar2(10)      ,/* 資金中心 */
fmbg003       date      ,/* 日期 */
fmbgownid       varchar2(20)      ,/* 資料所有者 */
fmbgowndp       varchar2(10)      ,/* 資料所屬部門 */
fmbgcrtid       varchar2(20)      ,/* 資料建立者 */
fmbgcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmbgcrtdt       timestamp(0)      ,/* 資料創建日 */
fmbgmodid       varchar2(20)      ,/* 資料修改者 */
fmbgmoddt       timestamp(0)      ,/* 資料修改日 */
fmbgcnfid       varchar2(20)      ,/* 資料確認者 */
fmbgcnfdt       timestamp(0)      ,/* 資料確認日 */
fmbgpstid       varchar2(20)      ,/* 資料過帳者 */
fmbgpstdt       timestamp(0)      ,/* 資料過帳日 */
fmbgstus       varchar2(10)      /* 狀態 */
);
alter table fmbg_t add constraint fmbg_pk primary key (fmbgent,fmbg001) enable validate;

create unique index fmbg_pk on fmbg_t (fmbgent,fmbg001);

grant select on fmbg_t to tiptop;
grant update on fmbg_t to tiptop;
grant delete on fmbg_t to tiptop;
grant insert on fmbg_t to tiptop;

exit;
