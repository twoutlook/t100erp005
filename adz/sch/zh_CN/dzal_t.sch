/* 
================================================================================
檔案代號:dzal_t
檔案名稱:程式串查設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzal_t
(
dzalstus       varchar2(10)      ,/* 狀態碼 */
dzal001       varchar2(20)      ,/* 規格編號 */
dzal002       varchar2(60)      ,/* 控件編號 */
dzal003       number(10)      ,/* 識別碼版次 */
dzal004       varchar2(1)      ,/* 使用標示 */
dzal005       varchar2(60)      ,/* 依附控件編號 */
dzal006       varchar2(255)      ,/* 程式參考設定 */
dzalownid       varchar2(20)      ,/* 資料所有者 */
dzalowndp       varchar2(10)      ,/* 資料所屬部門 */
dzalcrtid       varchar2(20)      ,/* 資料建立者 */
dzalcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzalcrtdt       timestamp(0)      ,/* 資料創建日 */
dzalmodid       varchar2(20)      ,/* 資料修改者 */
dzalmoddt       timestamp(0)      ,/* 最近修改日 */
dzal007       varchar2(1)      ,/* 串查型態 */
dzal008       number(5,0)      ,/* 項次 */
dzal009       varchar2(40)      /* 客戶代號 */
);
alter table dzal_t add constraint dzal_pk primary key (dzal001,dzal002,dzal003,dzal004,dzal008) enable validate;

create unique index dzal_pk on dzal_t (dzal001,dzal002,dzal003,dzal004,dzal008);

grant select on dzal_t to tiptop;
grant update on dzal_t to tiptop;
grant delete on dzal_t to tiptop;
grant insert on dzal_t to tiptop;

exit;
