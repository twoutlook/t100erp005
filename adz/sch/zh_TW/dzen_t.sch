/* 
================================================================================
檔案代號:dzen_t
檔案名稱:表格權限賦予檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzen_t
(
dzen001       varchar2(15)      ,/* Table代號 */
dzen002       varchar2(20)      ,/* 授與權限角色 */
dzen003       varchar2(20)      ,/* 取得權限角色 */
dzen004       varchar2(1)      ,/* SELECT */
dzen005       varchar2(1)      ,/* INSERT */
dzen006       varchar2(1)      ,/* UPDATE */
dzen007       varchar2(1)      ,/* DELETE */
dzen008       varchar2(1)      ,/* REFERENCES */
dzen009       varchar2(1)      ,/* ALTER */
dzen010       varchar2(1)      ,/* INDEX */
dzen011       varchar2(1)      ,/* 客制標示 */
dzen012       varchar2(1)      ,/* 原始客制標示 */
dzen013       varchar2(1)      ,/* 出貨標示 */
dzencrtid       varchar2(20)      ,/* 資料建立者 */
dzencrtdt       timestamp(0)      ,/* 資料創建日 */
dzenmodid       varchar2(20)      ,/* 資料修改者 */
dzenmoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzen_t add constraint dzen_pk primary key (dzen001,dzen002,dzen003) enable validate;

create unique index dzen_pk on dzen_t (dzen001,dzen002,dzen003);

grant select on dzen_t to tiptop;
grant update on dzen_t to tiptop;
grant delete on dzen_t to tiptop;
grant insert on dzen_t to tiptop;

exit;
