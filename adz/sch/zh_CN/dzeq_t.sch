/* 
================================================================================
檔案代號:dzeq_t
檔案名稱:樹狀結構設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzeq_t
(
dzeqstus       varchar2(10)      ,/* 狀態碼 */
dzeq001       varchar2(60)      ,/* 對應 Table Name */
dzeq002       varchar2(1)      ,/* No Use */
dzeq003       varchar2(1)      ,/* No Use */
dzeq004       varchar2(1)      ,/* No Use */
dzeq005       varchar2(1)      ,/* No Use */
dzeq006       number(10,0)      ,/* 序號 */
dzeq007       varchar2(60)      ,/* 類別(type, id, pid,desc, speed) */
dzeq008       varchar2(60)      ,/* Table Name */
dzeq009       varchar2(255)      ,/* Table Columnname */
dzeqownid       varchar2(20)      ,/* 資料所有者 */
dzeqowndp       varchar2(10)      ,/* 資料所屬部門 */
dzeqcrtid       varchar2(20)      ,/* 資料建立者 */
dzeqcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzeqcrtdt       timestamp(0)      ,/* 資料創建日 */
dzeqmodid       varchar2(20)      ,/* 資料修改者 */
dzeqmoddt       timestamp(0)      ,/* 最近修改日 */
dzeqcnfid       varchar2(20)      ,/* 資料確認者 */
dzeqcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzeq_t add constraint dzeq_pk primary key (dzeq001,dzeq006) enable validate;

create unique index dzeq_pk on dzeq_t (dzeq001,dzeq006);

grant select on dzeq_t to tiptop;
grant update on dzeq_t to tiptop;
grant delete on dzeq_t to tiptop;
grant insert on dzeq_t to tiptop;

exit;
