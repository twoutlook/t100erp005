/* 
================================================================================
檔案代號:dzai_t
檔案名稱:欄位參考設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzai_t
(
dzaistus       varchar2(10)      ,/* no use */
dzai001       varchar2(20)      ,/* 規格編號 */
dzai002       varchar2(60)      ,/* 控件編號 */
dzai003       number(10)      ,/* 識別碼版次 */
dzai004       varchar2(1)      ,/* 使用標示 */
dzai005       varchar2(60)      ,/* 依附控件編號 */
dzai007       varchar2(80)      ,/* 對應傳值設定 */
dzai008       varchar2(15)      ,/* 資料參考Table */
dzai009       varchar2(80)      ,/* 資料參考FK */
dzai010       varchar2(20)      ,/* 資料參考語系 */
dzai011       varchar2(20)      ,/* 資料參考回傳 */
dzaiownid       varchar2(20)      ,/* 資料所有者 */
dzaiowndp       varchar2(10)      ,/* 資料所屬部門 */
dzaicrtid       varchar2(20)      ,/* 資料建立者 */
dzaicrtdp       varchar2(10)      ,/* 資料建立部門 */
dzaicrtdt       timestamp(0)      ,/* 資料創建日 */
dzaimodid       varchar2(20)      ,/* 資料修改者 */
dzaimoddt       timestamp(0)      ,/* 最近修改日 */
dzai012       varchar2(40)      /* 客戶代號 */
);
alter table dzai_t add constraint dzai_pk primary key (dzai001,dzai002,dzai003,dzai004) enable validate;

create unique index dzai_pk on dzai_t (dzai001,dzai002,dzai003,dzai004);

grant select on dzai_t to tiptop;
grant update on dzai_t to tiptop;
grant delete on dzai_t to tiptop;
grant insert on dzai_t to tiptop;

exit;
