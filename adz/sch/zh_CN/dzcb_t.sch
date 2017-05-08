/* 
================================================================================
檔案代號:dzcb_t
檔案名稱:開窗設計參數設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzcb_t
(
dzcbstus       varchar2(10)      ,/* 狀態碼 */
dzcb001       varchar2(20)      ,/* 開窗設計識別碼 */
dzcb002       number(10,0)      ,/* 參數順序 */
dzcb003       varchar2(20)      ,/* 參數名稱 */
dzcb004       varchar2(1)      ,/* 客製 */
dzcbownid       varchar2(20)      ,/* 資料所有者 */
dzcbowndp       varchar2(10)      ,/* 資料所屬部門 */
dzcbcrtid       varchar2(20)      ,/* 資料建立者 */
dzcbcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzcbcrtdt       timestamp(0)      ,/* 資料創建日 */
dzcbmodid       varchar2(20)      ,/* 資料修改者 */
dzcbmoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzcb_t add constraint dzcb_pk primary key (dzcb001,dzcb002,dzcb004) enable validate;

create unique index dzcb_pk on dzcb_t (dzcb001,dzcb002,dzcb004);

grant select on dzcb_t to tiptop;
grant update on dzcb_t to tiptop;
grant delete on dzcb_t to tiptop;
grant insert on dzcb_t to tiptop;

exit;
