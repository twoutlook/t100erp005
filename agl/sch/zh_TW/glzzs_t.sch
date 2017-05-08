/* 
================================================================================
檔案代號:glzzs_t
檔案名稱:南京教育训练使用表格手工录入提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table glzzs_t
(
glzzsent       number(5)      ,/* 企業代碼 */
glzzs001       varchar2(10)      ,/* 测试一 */
glzzs002       varchar2(10)      ,/* 测试二 */
glzzs003       varchar2(40)      ,/* 提速值 */
glzzs004       number(5,0)      /* 階層 */
);
alter table glzzs_t add constraint glzzs_pk primary key (glzzsent,glzzs001,glzzs002,glzzs003) enable validate;


grant select on glzzs_t to tiptop;
grant update on glzzs_t to tiptop;
grant delete on glzzs_t to tiptop;
grant insert on glzzs_t to tiptop;

exit;
