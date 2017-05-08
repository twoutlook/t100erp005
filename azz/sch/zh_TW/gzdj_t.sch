/* 
================================================================================
檔案代號:gzdj_t
檔案名稱:子程式及應用函式開放記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table gzdj_t
(
gzdjownid       varchar2(20)      ,/* 資料所有者 */
gzdjowndp       varchar2(10)      ,/* 資料所屬部門 */
gzdjcrtid       varchar2(20)      ,/* 資料建立者 */
gzdjcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzdjcrtdt       timestamp(0)      ,/* 資料創建日 */
gzdjmodid       varchar2(20)      ,/* 資料修改者 */
gzdjmoddt       timestamp(0)      ,/* 最近修改日 */
gzdjstus       varchar2(10)      ,/* 狀態碼 */
gzdj001       varchar2(80)      ,/* FUNCTION編號 */
gzdj002       number(5,0)      ,/* 傳入參數數量 */
gzdj003       varchar2(500)      ,/* 傳入參數清單 */
gzdj004       varchar2(10)      ,/* 公開或私有 */
gzdj005       timestamp(0)      ,/* 放開時間 */
gzdj006       varchar2(20)      ,/* 申請人 */
gzdj007       varchar2(80)      /* 申請原因 */
);
alter table gzdj_t add constraint gzdj_pk primary key (gzdj001,gzdj005) enable validate;

create unique index gzdj_pk on gzdj_t (gzdj001,gzdj005);

grant select on gzdj_t to tiptop;
grant update on gzdj_t to tiptop;
grant delete on gzdj_t to tiptop;
grant insert on gzdj_t to tiptop;

exit;
