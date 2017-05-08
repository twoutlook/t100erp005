/* 
================================================================================
檔案代號:glzzl_t
檔案名稱:南京教育训练使用表格手工录入多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glzzl_t
(
glzzlent       number(5)      ,/* 企業代碼 */
glzzl001       varchar2(10)      ,/* 测试一 */
glzzl002       varchar2(10)      ,/* 测试二 */
glzzl003       varchar2(6)      ,/* 語言別 */
glzzl004       varchar2(500)      ,/* 說明 */
glzzl005       varchar2(10)      /* 助記碼 */
);
alter table glzzl_t add constraint glzzl_pk primary key (glzzlent,glzzl001,glzzl002,glzzl003) enable validate;


grant select on glzzl_t to tiptop;
grant update on glzzl_t to tiptop;
grant delete on glzzl_t to tiptop;
grant insert on glzzl_t to tiptop;

exit;
