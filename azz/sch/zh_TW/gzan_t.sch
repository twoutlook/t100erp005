/* 
================================================================================
檔案代號:gzan_t
檔案名稱:开账设置字段数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzan_t
(
gzan001       varchar2(15)      ,/* 作业编号 */
gzan002       varchar2(10)      ,/* 格式编号 */
gzan003       varchar2(15)      ,/* 表格编号 */
gzan004       varchar2(20)      ,/* 字段编号 */
gzan005       varchar2(1)      ,/* 导出 */
gzan006       number(5,0)      ,/* sheet页签 */
gzan007       number(5,0)      ,/* 字段顺序 */
gzan008       varchar2(10)      ,/* 数据类型 */
gzan009       varchar2(1)      ,/* 必要 */
gzan010       varchar2(100)      ,/* 默认值 */
gzan011       varchar2(500)      ,/* 条件给值 */
gzan012       varchar2(500)      ,/* 关联字段给值 */
gzan013       varchar2(500)      ,/* 应用元件/校验 */
gzan014       number(5,0)      ,/* 回传值数量 */
gzan015       number(5,0)      ,/* 回传值检查 */
gzan016       number(5,0)      ,/* 回传值给值 */
gzan017       varchar2(80)      ,/* 限制SCC选项 */
gzan018       varchar2(1)      ,/* 由下单身回写 */
gzan019       varchar2(1)      ,/* 生成否 */
gzan020       number(5,0)      /* 数据处理顺序 */
);
alter table gzan_t add constraint gzan_pk primary key (gzan001,gzan002,gzan003,gzan004) enable validate;

create unique index gzan_pk on gzan_t (gzan001,gzan002,gzan003,gzan004);

grant select on gzan_t to tiptop;
grant update on gzan_t to tiptop;
grant delete on gzan_t to tiptop;
grant insert on gzan_t to tiptop;

exit;
