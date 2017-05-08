/* 
================================================================================
檔案代號:pcadl_t
檔案名稱:POS模塊基本資料多語言表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pcadl_t
(
pcadlent       number(5)      ,/* 企業編號 */
pcadl001       varchar2(40)      ,/* 模塊編號 */
pcadl002       varchar2(6)      ,/* 語言別 */
pcadl003       varchar2(500)      ,/* 說明 */
pcadl004       varchar2(10)      /* 助記碼 */
);
alter table pcadl_t add constraint pcadl_pk primary key (pcadlent,pcadl001,pcadl002) enable validate;

create unique index pcadl_pk on pcadl_t (pcadlent,pcadl001,pcadl002);

grant select on pcadl_t to tiptop;
grant update on pcadl_t to tiptop;
grant delete on pcadl_t to tiptop;
grant insert on pcadl_t to tiptop;

exit;
