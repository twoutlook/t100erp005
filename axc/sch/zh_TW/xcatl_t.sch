/* 
================================================================================
檔案代號:xcatl_t
檔案名稱:成本類型設置檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xcatl_t
(
xcatlent       number(5)      ,/* 企業編號 */
xcatl001       varchar2(10)      ,/* 成本類型編號 */
xcatl002       varchar2(6)      ,/* 語言別 */
xcatl003       varchar2(500)      ,/* 成本類型說明 */
xcatl004       varchar2(10)      /* 助記碼 */
);
alter table xcatl_t add constraint xcatl_pk primary key (xcatlent,xcatl001,xcatl002) enable validate;

create unique index xcatl_pk on xcatl_t (xcatlent,xcatl001,xcatl002);

grant select on xcatl_t to tiptop;
grant update on xcatl_t to tiptop;
grant delete on xcatl_t to tiptop;
grant insert on xcatl_t to tiptop;

exit;
