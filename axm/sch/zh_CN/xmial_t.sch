/* 
================================================================================
檔案代號:xmial_t
檔案名稱:銷售預測編號設定檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xmial_t
(
xmialent       number(5)      ,/* 企業編號 */
xmial001       varchar2(10)      ,/* 預測編號 */
xmial002       varchar2(6)      ,/* 語言別 */
xmial003       varchar2(500)      ,/* 說明 */
xmial004       varchar2(10)      /* 助記碼 */
);
alter table xmial_t add constraint xmial_pk primary key (xmialent,xmial001,xmial002) enable validate;

create unique index xmial_pk on xmial_t (xmialent,xmial001,xmial002);

grant select on xmial_t to tiptop;
grant update on xmial_t to tiptop;
grant delete on xmial_t to tiptop;
grant insert on xmial_t to tiptop;

exit;
