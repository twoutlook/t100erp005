/* 
================================================================================
檔案代號:glzz_t
檔案名稱:南京教育训练使用表格手工录入
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glzz_t
(
glzzent       number(5)      ,/* 企業代碼 */
glzz001       varchar2(10)      ,/* 测试一 */
glzz002       varchar2(10)      ,/* 测试二 */
glzz003       varchar2(1)      ,/* 测试三 */
glzz004       varchar2(10)      ,/* 测试四 */
glzz005       varchar2(10)      ,/* 测试五 */
glzz006       varchar2(1)      ,/* 测试六 */
glzzownid       varchar2(10)      ,/* 資料所有者 */
glzzowndp       varchar2(10)      ,/* 資料所屬部門 */
glzzcrtid       varchar2(10)      ,/* 資料建立者 */
glzzcrtdp       varchar2(10)      ,/* 資料建立部門 */
glzzcrtdt       date      ,/* 資料創建日 */
glzzmodid       varchar2(10)      ,/* 資料修改者 */
glzzmoddt       date      ,/* 最近修改日 */
glzzstus       varchar2(10)      /* 狀態碼 */
);
alter table glzz_t add constraint glzz_pk primary key (glzzent,glzz001,glzz002) enable validate;


grant select on glzz_t to tiptop;
grant update on glzz_t to tiptop;
grant delete on glzz_t to tiptop;
grant insert on glzz_t to tiptop;

exit;
