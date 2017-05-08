/* 
================================================================================
檔案代號:gzid_t
檔案名稱:自定义查询-QBE字段明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzid_t
(
gzid001       varchar2(20)      ,/* 查询单ID */
gzid002       number(5,0)      ,/* 序号 */
gzid003       varchar2(20)      ,/* 资料表 */
gzid004       varchar2(500)      ,/* 字段编号 */
gzid005       varchar2(1)      ,/* 打印显示设置 */
gzid006       number(10,0)      ,/* 画面字段宽度 */
gzid007       number(10,0)      ,/* 打印窗口显示顺序 */
gzid008       varchar2(1)      ,/* 开窗(qbe) */
gzid009       varchar2(20)      ,/* 查询程序编号 */
gzid010       varchar2(4)      ,/* 字段属性 */
gzid011       varchar2(20)      ,/* 币种字段/小数字 */
gzid012       varchar2(1)      ,/* 数据转换 */
gzid013       varchar2(40)      ,/* 数据类型 */
gzid014       varchar2(1)      ,/* 串查flag */
gzid015       varchar2(20)      ,/* 串查对应作业编号 */
gzid016       varchar2(40)      ,/* 字段别名 */
gzid017       varchar2(500)      ,/* 串查参数 */
gzid018       number(5,0)      /* qbe窗口显示顺序 */
);
alter table gzid_t add constraint gzid_pk primary key (gzid001,gzid002) enable validate;

create unique index gzid_pk on gzid_t (gzid001,gzid002);

grant select on gzid_t to tiptop;
grant update on gzid_t to tiptop;
grant delete on gzid_t to tiptop;
grant insert on gzid_t to tiptop;

exit;
