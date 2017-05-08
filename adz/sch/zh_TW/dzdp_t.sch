/* 
================================================================================
檔案代號:dzdp_t
檔案名稱:元件規格與元件版次對應表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdp_t
(
dzdp001       varchar2(20)      ,/* 元件規格代號 */
dzdp002       number(10)      ,/* 規格版次 */
dzdp003       varchar2(40)      ,/* 元件代號 */
dzdp004       number(10)      ,/* 元件版次 */
dzdp005       varchar2(20)      ,/* 產品版本 */
dzdpownid       varchar2(20)      ,/* 資料所有者 */
dzdpowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdpcrtid       varchar2(20)      ,/* 資料建立者 */
dzdpcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdpcrtdt       timestamp(0)      ,/* 資料創建日 */
dzdpmodid       varchar2(20)      ,/* 資料修改者 */
dzdpmoddt       timestamp(0)      ,/* 最近修改日 */
dzdpstus       varchar2(10)      ,/* 狀態碼 */
dzdp006       varchar2(1)      ,/* 客製 */
dzdp007       varchar2(40)      ,/* 客戶代號 */
dzdp008       varchar2(1)      /* 使用標示 */
);
alter table dzdp_t add constraint dzdp_pk primary key (dzdp001,dzdp002,dzdp003,dzdp006) enable validate;

create unique index dzdp_pk on dzdp_t (dzdp001,dzdp002,dzdp003,dzdp006);

grant select on dzdp_t to tiptop;
grant update on dzdp_t to tiptop;
grant delete on dzdp_t to tiptop;
grant insert on dzdp_t to tiptop;

exit;
