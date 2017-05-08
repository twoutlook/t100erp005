/* 
================================================================================
檔案代號:rpxb_t
檔案名稱:APP使用者對角色或作業配置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rpxb_t
(
rpxbownid       varchar2(20)      ,/* 資料所有者 */
rpxbowndp       varchar2(10)      ,/* 資料所屬部門 */
rpxbcrtid       varchar2(20)      ,/* 資料建立者 */
rpxbcrtdp       varchar2(10)      ,/* 資料建立部門 */
rpxbcrtdt       timestamp(0)      ,/* 資料創建日 */
rpxbmodid       varchar2(20)      ,/* 資料修改者 */
rpxbmoddt       timestamp(0)      ,/* 最近修改日 */
rpxbstus       varchar2(10)      ,/* 狀態碼 */
rpxbent       number(5)      ,/* 企業代碼 */
rpxb001       varchar2(20)      ,/* 使用者編號 */
rpxb002       varchar2(20)      ,/* APP編號 */
rpxb003       varchar2(1)      ,/* 類別 */
rpxb004       varchar2(20)      /* 功能編號或角色 */
);
alter table rpxb_t add constraint rpxb_pk primary key (rpxbent,rpxb001,rpxb002,rpxb003,rpxb004) enable validate;

create unique index rpxb_pk on rpxb_t (rpxbent,rpxb001,rpxb002,rpxb003,rpxb004);

grant select on rpxb_t to tiptop;
grant update on rpxb_t to tiptop;
grant delete on rpxb_t to tiptop;
grant insert on rpxb_t to tiptop;

exit;
