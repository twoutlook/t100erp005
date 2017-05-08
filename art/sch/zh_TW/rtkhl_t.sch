/* 
================================================================================
檔案代號:rtkhl_t
檔案名稱:自動補貨補貨模型多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table rtkhl_t
(
rtkhlent       number(5)      ,/* 企業編號 */
rtkhl001       varchar2(10)      ,/* 模型編號 */
rtkhl002       varchar2(6)      ,/* 語言別 */
rtkhl003       varchar2(500)      ,/* 說明 */
rtkhl004       varchar2(10)      /* 助記碼 */
);
alter table rtkhl_t add constraint rtkhl_pk primary key (rtkhlent,rtkhl001,rtkhl002) enable validate;

create unique index rtkhl_pk on rtkhl_t (rtkhlent,rtkhl001,rtkhl002);

grant select on rtkhl_t to tiptop;
grant update on rtkhl_t to tiptop;
grant delete on rtkhl_t to tiptop;
grant insert on rtkhl_t to tiptop;

exit;
