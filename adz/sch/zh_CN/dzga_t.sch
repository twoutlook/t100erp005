/* 
================================================================================
檔案代號:dzga_t
檔案名稱:報表元件設計主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzga_t
(
dzgastus       varchar2(10)      ,/* 狀態碼 */
dzga001       varchar2(20)      ,/* 報表元件代號 */
dzga002       number(10)      ,/* 版次 */
dzga003       varchar2(1)      ,/* 報表工具 */
dzga004       varchar2(20)      ,/* 報表類型 */
dzgaownid       varchar2(20)      ,/* 資料所有者 */
dzgaowndp       varchar2(10)      ,/* 資料所屬部門 */
dzgacrtid       varchar2(20)      ,/* 資料建立者 */
dzgacrtdp       varchar2(10)      ,/* 資料建立部們 */
dzgacrtdt       timestamp(0)      ,/* 資料創建日 */
dzgamodid       varchar2(20)      ,/* 資料修改者 */
dzgamoddt       timestamp(0)      ,/* 最近修改日 */
dzga005       varchar2(40)      ,/* 客戶代號 */
dzga006       varchar2(1)      /* 客製 */
);
alter table dzga_t add constraint dzga_pk primary key (dzga001,dzga002,dzga006) enable validate;

create unique index dzga_pk on dzga_t (dzga001,dzga002,dzga006);

grant select on dzga_t to tiptop;
grant update on dzga_t to tiptop;
grant delete on dzga_t to tiptop;
grant insert on dzga_t to tiptop;

exit;
