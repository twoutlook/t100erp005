/* 
================================================================================
檔案代號:dzve_t
檔案名稱:树状结构属性设置档(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzve_t
(
dzvestus       varchar2(10)      ,/* 状态码 */
dzve001       varchar2(20)      ,/* 程式代号 */
dzve002       varchar2(15)      ,/* 识别码版号 */
dzve003       varchar2(40)      ,/* 4fd tag name */
dzve004       number(5,0)      ,/* 编号 */
dzve005       varchar2(20)      ,/* 属性(ex.描述desc,pid,id,type,提速档speed,spid,sid,stype) */
dzve006       varchar2(15)      ,/* 资料表代码 */
dzve007       varchar2(20)      ,/* 字段代码 */
dzve008       varchar2(1)      ,/* 使用标示 */
dzveownid       varchar2(10)      ,/* 资料所有者 */
dzveowndp       varchar2(10)      ,/* 资料所有部门 */
dzvecrtid       varchar2(10)      ,/* 资料建立者 */
dzvecrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvecrtdt       date      ,/* 资料创建日 */
dzvemodid       varchar2(10)      ,/* 资料修改者 */
dzvemoddt       date      ,/* 最近修改日 */
dzve009       varchar2(40)      /* 客户代号 */
);
alter table dzve_t add constraint dzve_pk primary key (dzve001,dzve002,dzve003,dzve005,dzve008) enable validate;


grant select on dzve_t to tiptop;
grant update on dzve_t to tiptop;
grant delete on dzve_t to tiptop;
grant insert on dzve_t to tiptop;

exit;
