/* 
================================================================================
檔案代號:stfnl_t
檔案名稱:聯營合同模板主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table stfnl_t
(
stfnlent       number(5)      ,/* 企業編號 */
stfnl001       varchar2(10)      ,/* 模板編號 */
stfnl002       varchar2(6)      ,/* 語言別 */
stfnl003       varchar2(500)      ,/* 說明 */
stfnl004       varchar2(10)      /* 助記碼 */
);
alter table stfnl_t add constraint stfnl_pk primary key (stfnlent,stfnl001,stfnl002) enable validate;

create unique index stfnl_pk on stfnl_t (stfnlent,stfnl001,stfnl002);

grant select on stfnl_t to tiptop;
grant update on stfnl_t to tiptop;
grant delete on stfnl_t to tiptop;
grant insert on stfnl_t to tiptop;

exit;
