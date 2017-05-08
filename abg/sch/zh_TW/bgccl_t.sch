/* 
================================================================================
檔案代號:bgccl_t
檔案名稱:銷售模擬收入項目主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgccl_t
(
bgcclent       number(5)      ,/* 企業編號 */
bgccl001       varchar2(10)      ,/* 模擬收入項目 */
bgccl002       varchar2(6)      ,/* 語言別 */
bgccl003       varchar2(500)      ,/* 說明 */
bgccl004       varchar2(10)      /* 助記碼 */
);
alter table bgccl_t add constraint bgccl_pk primary key (bgcclent,bgccl001,bgccl002) enable validate;

create unique index bgccl_pk on bgccl_t (bgcclent,bgccl001,bgccl002);

grant select on bgccl_t to tiptop;
grant update on bgccl_t to tiptop;
grant delete on bgccl_t to tiptop;
grant insert on bgccl_t to tiptop;

exit;
