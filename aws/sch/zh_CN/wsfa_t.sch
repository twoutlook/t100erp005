/* 
================================================================================
檔案代號:wsfa_t
檔案名稱:集成执行记录档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsfa_t
(
wsfa001       varchar2(40)      ,/* 服务名称 */
wsfa002       number(10,0)      ,/* process_id */
wsfa003       varchar2(40)      ,/* 起始时间 */
wsfa004       varchar2(40)      ,/* 结束时间 */
wsfa005       varchar2(30)      ,/* 处理时间 */
wsfa006       varchar2(10)      ,/* 状态 */
wsfa007       varchar2(100)      ,/* request文件路径 */
wsfa008       varchar2(100)      ,/* response文件路径 */
wsfa009       varchar2(10)      /* 记录种类 */
);
alter table wsfa_t add constraint wsfa_pk primary key (wsfa001,wsfa002,wsfa003) enable validate;

create unique index wsfa_pk on wsfa_t (wsfa001,wsfa002,wsfa003);

grant select on wsfa_t to tiptop;
grant update on wsfa_t to tiptop;
grant delete on wsfa_t to tiptop;
grant insert on wsfa_t to tiptop;

exit;
