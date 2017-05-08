/* 
================================================================================
檔案代號:xmaal_t
檔案名稱:信用評等公式資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table xmaal_t
(
xmaalent       number(5)      ,/* 企業編號 */
xmaal001       varchar2(10)      ,/* 信用評等編號 */
xmaal002       varchar2(6)      ,/* 語言別 */
xmaal003       varchar2(500)      ,/* 說明 */
xmaal004       varchar2(10)      /* 助記碼 */
);
alter table xmaal_t add constraint xmaal_pk primary key (xmaalent,xmaal001,xmaal002) enable validate;


grant select on xmaal_t to tiptop;
grant update on xmaal_t to tiptop;
grant delete on xmaal_t to tiptop;
grant insert on xmaal_t to tiptop;

exit;
