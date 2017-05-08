/* 
================================================================================
檔案代號:xcjal_t
檔案名稱:內部交易計算基礎設定多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xcjal_t
(
xcjalent       number(5)      ,/* 企業編號 */
xcjal001       varchar2(10)      ,/* 計算類型(版本) */
xcjal002       varchar2(6)      ,/* 語言別 */
xcjal003       varchar2(500)      ,/* 說明 */
xcjal004       varchar2(10)      /* 助記碼 */
);
alter table xcjal_t add constraint xcjal_pk primary key (xcjalent,xcjal001,xcjal002) enable validate;

create unique index xcjal_pk on xcjal_t (xcjalent,xcjal001,xcjal002);

grant select on xcjal_t to tiptop;
grant update on xcjal_t to tiptop;
grant delete on xcjal_t to tiptop;
grant insert on xcjal_t to tiptop;

exit;
