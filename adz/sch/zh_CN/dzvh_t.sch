/* 
================================================================================
檔案代號:dzvh_t
檔案名稱:程序Table与Screen Record对应档(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvh_t
(
dzvhstus       varchar2(10)      ,/* 状态码 */
dzvh001       varchar2(15)      ,/* 识别码版号 */
dzvh002       varchar2(20)      ,/* 程式代号 */
dzvh003       varchar2(40)      ,/* Screen Record */
dzvh004       varchar2(15)      ,/* 数据表编号 */
dzvh005       varchar2(1)      ,/* 使用标示 */
dzvhownid       varchar2(10)      ,/* 资料所有者 */
dzvhowndp       varchar2(10)      ,/* 资料所有部门 */
dzvhcrtid       varchar2(10)      ,/* 资料建立者 */
dzvhcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvhcrtdt       date      ,/* 资料创建日 */
dzvhmodid       varchar2(10)      ,/* 资料修改者 */
dzvhmoddt       date      ,/* 最近修改日 */
dzvh006       varchar2(1)      ,/* 允许插入 */
dzvh007       varchar2(1)      ,/* 允许删除 */
dzvh008       varchar2(1)      ,/* 允许新增 */
dzvh009       varchar2(1)      ,/* 是否连动 */
dzvh010       varchar2(20)      ,/* 种类 */
dzvh011       varchar2(40)      ,/* 客户代号 */
dzvh012       varchar2(1)      /* patch标示 */
);
alter table dzvh_t add constraint dzvh_pk primary key (dzvh001,dzvh002,dzvh003,dzvh005) enable validate;


grant select on dzvh_t to tiptop;
grant update on dzvh_t to tiptop;
grant delete on dzvh_t to tiptop;
grant insert on dzvh_t to tiptop;

exit;
