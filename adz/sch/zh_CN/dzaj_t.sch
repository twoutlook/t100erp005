/* 
================================================================================
檔案代號:dzaj_t
檔案名稱:欄位資料多語言設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzaj_t
(
dzajstus       varchar2(10)      ,/* no use */
dzaj001       varchar2(20)      ,/* 規格編號 */
dzaj002       varchar2(60)      ,/* 控件編號 */
dzaj003       number(10)      ,/* 識別碼版次 */
dzaj004       varchar2(1)      ,/* 使用標示 */
dzaj005       varchar2(60)      ,/* 依附控件編號 */
dzaj007       varchar2(80)      ,/* 對應傳值設定 */
dzaj008       varchar2(15)      ,/* 多語言Table */
dzaj009       varchar2(80)      ,/* 多語言FK */
dzaj010       varchar2(20)      ,/* 多語言語系 */
dzaj011       varchar2(20)      ,/* 多語言回傳 */
dzajownid       varchar2(20)      ,/* 資料所有者 */
dzajowndp       varchar2(10)      ,/* 資料所屬部門 */
dzajcrtid       varchar2(20)      ,/* 資料建立者 */
dzajcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzajcrtdt       timestamp(0)      ,/* 資料創建日 */
dzajmodid       varchar2(20)      ,/* 資料修改者 */
dzajmoddt       timestamp(0)      ,/* 最近修改日 */
dzaj099       clob      ,/* 規格描述 */
dzaj012       varchar2(40)      /* 客戶代號 */
);
alter table dzaj_t add constraint dzaj_pk primary key (dzaj001,dzaj002,dzaj003,dzaj004) enable validate;

create unique index dzaj_pk on dzaj_t (dzaj001,dzaj002,dzaj003,dzaj004);

grant select on dzaj_t to tiptop;
grant update on dzaj_t to tiptop;
grant delete on dzaj_t to tiptop;
grant insert on dzaj_t to tiptop;

exit;
