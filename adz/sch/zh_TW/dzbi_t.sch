/* 
================================================================================
檔案代號:dzbi_t
檔案名稱:Patch保留标准add point内容for topstd追单
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzbi_t
(
dzbi001       varchar2(20)      ,/* 来源程序编号 */
dzbi002       number(10)      ,/* 来源程序版次 */
dzbi003       varchar2(60)      ,/* 识别码名称 */
dzbi004       number(10)      ,/* 识别码版次 */
dzbi005       varchar2(80)      ,/* Patch编号 */
dzbi006       varchar2(1)      ,/* 识别码类型 */
dzbi007       varchar2(1)      ,/* 下方的硬结构编号整段注解 */
dzbi008       varchar2(1)      ,/* 来源使用标示 */
dzbi098       clob      ,/* 程序内容 */
dzbistus       varchar2(10)      ,/* 状态码 */
dzbiownid       varchar2(20)      ,/* 数据所有者 */
dzbiowndp       varchar2(10)      ,/* 数据所属部门 */
dzbicrtid       varchar2(20)      ,/* 数据录入者 */
dzbicrtdp       varchar2(10)      ,/* 数据录入部门 */
dzbicrtdt       timestamp(0)      ,/* 数据创建日 */
dzbimodid       varchar2(20)      ,/* 数据更改者 */
dzbimoddt       timestamp(0)      /* 最近更改日 */
);
alter table dzbi_t add constraint dzbi_pk primary key (dzbi001,dzbi003,dzbi005,dzbi006) enable validate;

create unique index dzbi_pk on dzbi_t (dzbi001,dzbi003,dzbi005,dzbi006);

grant select on dzbi_t to tiptop;
grant update on dzbi_t to tiptop;
grant delete on dzbi_t to tiptop;
grant insert on dzbi_t to tiptop;

exit;
