/* 
================================================================================
檔案代號:gzgj_t
檔案名稱:報表表頭設定單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzgj_t
(
gzgjstus       varchar2(10)      ,/* 狀態碼 */
gzgj001       varchar2(10)      ,/* 表頭代號 */
gzgj002       varchar2(6)      ,/* 語言別 */
gzgj003       number(5,0)      ,/* 表頭行數 */
gzgj004       number(5,0)      ,/* 每行欄數 */
gzgj005       number(5,0)      ,/* 欄寬比例1 */
gzgj006       number(5,0)      ,/* 欄寬比例2 */
gzgj007       number(5,0)      ,/* 欄寬比例3 */
gzgj008       number(5,0)      ,/* 欄寬比例4 */
gzgjownid       varchar2(20)      ,/* 資料所有者 */
gzgjowndp       varchar2(10)      ,/* 資料所屬部門 */
gzgjcrtid       varchar2(20)      ,/* 資料建立者 */
gzgjcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzgjcrtdt       timestamp(0)      ,/* 資料創建日 */
gzgjmodid       varchar2(20)      ,/* 資料修改者 */
gzgjmoddt       timestamp(0)      ,/* 最近修改日 */
gzgj009       varchar2(1)      ,/* LOGO位罝/列印條件顯示否 */
gzgj010       varchar2(1)      /* 報表區段 */
);
alter table gzgj_t add constraint gzgj_pk primary key (gzgj001,gzgj002,gzgj010) enable validate;

create unique index gzgj_pk on gzgj_t (gzgj001,gzgj002,gzgj010);

grant select on gzgj_t to tiptop;
grant update on gzgj_t to tiptop;
grant delete on gzgj_t to tiptop;
grant insert on gzgj_t to tiptop;

exit;
