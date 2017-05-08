/* 
================================================================================
檔案代號:dzbf_t
檔案名稱:標準與客製程式段相互還原紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzbf_t
(
dzbf001       varchar2(20)      ,/* 代碼編號 */
dzbf002       varchar2(60)      ,/* 代碼設計點 */
dzbf003       varchar2(1)      ,/* 還原類型 */
dzbf004       number(10)      ,/* 還原前設計點版次 */
dzbf005       varchar2(1)      ,/* 還原前使用標示 */
dzbf006       number(10)      ,/* 還原後設計點版次 */
dzbf007       varchar2(1)      ,/* 還原後使用標示 */
dzbf008       number(10)      ,/* 客製程式版次 */
dzbfownid       varchar2(20)      ,/* 資料所有者 */
dzbfowndp       varchar2(10)      ,/* 資料所屬部門 */
dzbfcrtid       varchar2(20)      ,/* 資料建立者 */
dzbfcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzbfcrtdt       timestamp(0)      ,/* 資料創建日 */
dzbfmodid       varchar2(20)      ,/* 資料修改者 */
dzbfmoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzbf_t add constraint dzbf_pk primary key (dzbf001,dzbf002,dzbf008) enable validate;

create unique index dzbf_pk on dzbf_t (dzbf001,dzbf002,dzbf008);

grant select on dzbf_t to tiptop;
grant update on dzbf_t to tiptop;
grant delete on dzbf_t to tiptop;
grant insert on dzbf_t to tiptop;

exit;
