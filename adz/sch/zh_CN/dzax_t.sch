/* 
================================================================================
檔案代號:dzax_t
檔案名稱:程式設計基本設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzax_t
(
dzax001       varchar2(20)      ,/* 程式編號 */
dzax002       varchar2(10)      ,/* 程式樣版 */
dzaxownid       varchar2(20)      ,/* 資料所有者 */
dzaxowndp       varchar2(10)      ,/* 資料所屬部門 */
dzaxcrtid       varchar2(20)      ,/* 資料建立者 */
dzaxcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzaxcrtdt       timestamp(0)      ,/* 資料創建日 */
dzaxmodid       varchar2(20)      ,/* 資料修改者 */
dzaxmoddt       timestamp(0)      ,/* 最近修改日 */
dzaxstus       varchar2(10)      ,/* 狀態碼 */
dzax003       varchar2(1)      ,/* 是否為Free Style */
dzax004       varchar2(1)      ,/* 本版次異動 */
dzax005       varchar2(40)      ,/* 客戶代號 */
dzax006       varchar2(1)      ,/* 客製 */
dzax007       number(5,0)      /* 保留參數個數 */
);
alter table dzax_t add constraint dzax_pk primary key (dzax001,dzax006) enable validate;

create unique index dzax_pk on dzax_t (dzax001,dzax006);

grant select on dzax_t to tiptop;
grant update on dzax_t to tiptop;
grant delete on dzax_t to tiptop;
grant insert on dzax_t to tiptop;

exit;
