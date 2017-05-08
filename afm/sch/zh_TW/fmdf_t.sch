/* 
================================================================================
檔案代號:fmdf_t
檔案名稱:融资系统重评价單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmdf_t
(
fmdfent       number(5)      ,/* 企業編號 */
fmdfcomp       varchar2(10)      ,/* 法人 */
fmdfsite       varchar2(10)      ,/* 帳務中心 */
fmdfld       varchar2(5)      ,/* 帳別 */
fmdfdocno       varchar2(20)      ,/* 單據號碼 */
fmdfdocdt       date      ,/* 立帳日期 */
fmdf001       number(5,0)      ,/* 年度 */
fmdf002       number(5,0)      ,/* 期別 */
fmdf003       varchar2(20)      ,/* 傳票編號 */
fmdfstus       varchar2(10)      ,/* 狀態碼 */
fmdfownid       varchar2(20)      ,/* 資料所有者 */
fmdfowndp       varchar2(10)      ,/* 資料所屬部門 */
fmdfcrtid       varchar2(20)      ,/* 資料建立者 */
fmdfcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmdfcrtdt       timestamp(0)      ,/* 資料創建日 */
fmdfmodid       varchar2(20)      ,/* 資料修改者 */
fmdfmoddt       timestamp(0)      ,/* 最近修改日 */
fmdfcnfid       varchar2(20)      ,/* 資料確認者 */
fmdfcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table fmdf_t add constraint fmdf_pk primary key (fmdfent,fmdfld,fmdfdocno,fmdf001,fmdf002) enable validate;

create unique index fmdf_pk on fmdf_t (fmdfent,fmdfld,fmdfdocno,fmdf001,fmdf002);

grant select on fmdf_t to tiptop;
grant update on fmdf_t to tiptop;
grant delete on fmdf_t to tiptop;
grant insert on fmdf_t to tiptop;

exit;
