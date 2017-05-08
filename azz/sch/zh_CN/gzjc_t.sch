/* 
================================================================================
檔案代號:gzjc_t
檔案名稱:Client服务设置数据表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzjc_t
(
gzjcownid       varchar2(20)      ,/* 资料所有者 */
gzjcowndp       varchar2(10)      ,/* 资料所有部门 */
gzjccrtid       varchar2(20)      ,/* 资料录入者 */
gzjccrtdp       varchar2(10)      ,/* 资料录入部门 */
gzjccrtdt       timestamp(0)      ,/* 资料创建日 */
gzjcmodid       varchar2(20)      ,/* 资料更改者 */
gzjcmoddt       timestamp(0)      ,/* 最近更改日 */
gzjcstus       varchar2(10)      ,/* 状态码 */
gzjc001       varchar2(40)      ,/* WS服务名称 */
gzjc002       varchar2(40)      ,/* 元件代号 */
gzjc003       varchar2(20)      ,/* timeout时间 */
gzjc004       varchar2(1)      ,/* 客制 */
gzjc005       varchar2(1)      ,/* 集成方案 */
gzjc006       varchar2(1)      /* 信息内容格式 */
);
alter table gzjc_t add constraint gzjc_pk primary key (gzjc001) enable validate;

create unique index gzjc_pk on gzjc_t (gzjc001);

grant select on gzjc_t to tiptop;
grant update on gzjc_t to tiptop;
grant delete on gzjc_t to tiptop;
grant insert on gzjc_t to tiptop;

exit;
