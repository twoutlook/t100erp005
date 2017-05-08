/* 
================================================================================
檔案代號:dzcd_t
檔案名稱:校驗帶值設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzcd_t
(
dzcdstus       varchar2(10)      ,/* 狀態碼 */
dzcd001       varchar2(20)      ,/* 校驗帶值識別碼 */
dzcd002       varchar2(1)      ,/* 客製 */
dzcd003       varchar2(4000)      ,/* SQL指令 */
dzcd004       varchar2(20)      ,/* 不存在的提示資訊 */
dzcd005       varchar2(1)      ,/* 校驗帶值型態 */
dzcdownid       varchar2(20)      ,/* 資料所有者 */
dzcdowndp       varchar2(10)      ,/* 資料所屬部門 */
dzcdcrtid       varchar2(20)      ,/* 資料建立者 */
dzcdcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzcdcrtdt       timestamp(0)      ,/* 資料創建日 */
dzcdmodid       varchar2(20)      ,/* 資料修改者 */
dzcdmoddt       timestamp(0)      ,/* 最近修改日 */
dzcd006       varchar2(2)      ,/* 行業別 */
dzcd007       varchar2(1)      /* no use */
);
alter table dzcd_t add constraint dzcd_pk primary key (dzcd001,dzcd002) enable validate;

create unique index dzcd_pk on dzcd_t (dzcd001,dzcd002);

grant select on dzcd_t to tiptop;
grant update on dzcd_t to tiptop;
grant delete on dzcd_t to tiptop;
grant insert on dzcd_t to tiptop;

exit;
