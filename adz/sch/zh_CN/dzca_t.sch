/* 
================================================================================
檔案代號:dzca_t
檔案名稱:開窗資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzca_t
(
dzcastus       varchar2(10)      ,/* 狀態碼 */
dzca001       varchar2(20)      ,/* 開窗識別碼 */
dzca002       varchar2(1)      ,/* 客製 */
dzca003       varchar2(4000)      ,/* SQL指令 */
dzcaownid       varchar2(20)      ,/* 資料所有者 */
dzcaowndp       varchar2(10)      ,/* 資料所屬部門 */
dzcacrtid       varchar2(20)      ,/* 資料建立者 */
dzcacrtdp       varchar2(10)      ,/* 資料建立部門 */
dzcacrtdt       timestamp(0)      ,/* 資料創建日 */
dzcamodid       varchar2(20)      ,/* 資料修改者 */
dzcamoddt       timestamp(0)      ,/* 最近修改日 */
dzca004       number(10,0)      ,/* 每頁顯現資料筆數 */
dzca005       varchar2(20)      ,/* 作業串查代號 */
dzca006       varchar2(1)      ,/* Hard Code */
dzca007       varchar2(2)      ,/* 行業別 */
dzca008       varchar2(1)      /* 不共用主程式多語言 */
);
alter table dzca_t add constraint dzca_pk primary key (dzca001,dzca002) enable validate;

create unique index dzca_pk on dzca_t (dzca001,dzca002);

grant select on dzca_t to tiptop;
grant update on dzca_t to tiptop;
grant delete on dzca_t to tiptop;
grant insert on dzca_t to tiptop;

exit;
