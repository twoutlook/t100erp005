/* 
================================================================================
檔案代號:nmae_t
檔案名稱:法人資金參數基本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmae_t
(
nmaeent       number(5)      ,/* 企業代碼 */
nmaeownid       varchar2(10)      ,/* 資料所有者 */
nmaeowndp       varchar2(10)      ,/* 資料所屬部門 */
nmaecrtid       varchar2(10)      ,/* 資料建立者 */
nmaecrtdp       varchar2(10)      ,/* 資料建立部門 */
nmaecrtdt       date      ,/* 資料創建日 */
nmaemodid       varchar2(10)      ,/* 資料修改者 */
nmaemoddt       date      ,/* 最近修改日 */
nmaestus       varchar2(10)      ,/* 狀態碼 */
nmaecomp       varchar2(10)      ,/* 法人代碼 */
nmae001       varchar2(5)      ,/* 銀行節假日參照表 */
nmae002       varchar2(10)      ,/* 資金系統關帳日 */
nmae101       varchar2(1)      ,/* 資金計劃金額單位 */
nmae102       varchar2(10)      ,/* 內部資金調度利息計算天數基礎 */
nmae103       varchar2(10)      ,/* 內部資金撥入存提碼 */
nmae104       varchar2(10)      ,/* 內部資金撥出存提碼 */
nmae105       varchar2(10)      ,/* 內部資金應收利息存提碼 */
nmae106       varchar2(10)      ,/* 內部資金應付利息存提碼 */
nmae107       varchar2(10)      ,/* 內部資金手續費存提碼 */
nmae108       varchar2(10)      ,/* 內部資金調度撥出匯率原則 */
nmae109       varchar2(10)      /* 內部資金調度撥入匯率原則 */
);
alter table nmae_t add constraint nmae_pk primary key (nmaeent,nmaecomp) enable validate;


grant select on nmae_t to tiptop;
grant update on nmae_t to tiptop;
grant delete on nmae_t to tiptop;
grant insert on nmae_t to tiptop;

exit;
