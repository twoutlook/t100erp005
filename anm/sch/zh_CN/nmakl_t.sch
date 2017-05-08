/* 
================================================================================
檔案代號:nmakl_t
檔案名稱:現金分類多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table nmakl_t
(
nmaklent       number(5)      ,/* 企業編號 */
nmakl001       varchar2(10)      ,/* 現金異動碼 */
nmakl002       varchar2(6)      ,/* 語言別 */
nmakl003       varchar2(500)      /* 說明 */
);
alter table nmakl_t add constraint nmakl_pk primary key (nmaklent,nmakl001,nmakl002) enable validate;

create unique index nmakl_pk on nmakl_t (nmaklent,nmakl001,nmakl002);

grant select on nmakl_t to tiptop;
grant update on nmakl_t to tiptop;
grant delete on nmakl_t to tiptop;
grant insert on nmakl_t to tiptop;

exit;
