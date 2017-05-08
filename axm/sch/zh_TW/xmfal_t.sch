/* 
================================================================================
檔案代號:xmfal_t
檔案名稱:銷售報價範本單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xmfal_t
(
xmfalent       number(5)      ,/* 企業編號 */
xmfaldocno       varchar2(20)      ,/* 範本料號 */
xmfal002       varchar2(6)      ,/* 語言別 */
xmfal003       varchar2(500)      ,/* 說明 */
xmfal004       varchar2(10)      /* 助記碼 */
);
alter table xmfal_t add constraint xmfal_pk primary key (xmfalent,xmfaldocno,xmfal002) enable validate;

create unique index xmfal_pk on xmfal_t (xmfalent,xmfaldocno,xmfal002);

grant select on xmfal_t to tiptop;
grant update on xmfal_t to tiptop;
grant delete on xmfal_t to tiptop;
grant insert on xmfal_t to tiptop;

exit;
