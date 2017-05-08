/* 
================================================================================
檔案代號:dzvk_t
檔案名稱:字段助记码设计表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvk_t
(
dzvkstus       varchar2(10)      ,/* no use */
dzvk001       varchar2(20)      ,/* 规格编号 */
dzvk002       varchar2(60)      ,/* 控件编号 */
dzvk003       varchar2(15)      ,/* 识别码版次 */
dzvk004       varchar2(1)      ,/* 使用标示 */
dzvk005       varchar2(255)      ,/* 其他条件 */
dzvk007       varchar2(80)      ,/* 助记码搜寻字段 */
dzvk008       varchar2(15)      ,/* 助记码Table */
dzvk009       varchar2(20)      ,/* 助记码字段 */
dzvk010       varchar2(20)      ,/* 助记码语系 */
dzvk011       varchar2(255)      ,/* 回传对应控件 */
dzvkownid       varchar2(10)      ,/* 资料所有者 */
dzvkowndp       varchar2(10)      ,/* 资料所有部门 */
dzvkcrtid       varchar2(10)      ,/* 资料建立者 */
dzvkcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvkcrtdt       date      ,/* 资料创建日 */
dzvkmodid       varchar2(10)      ,/* 资料修改者 */
dzvkmoddt       date      ,/* 最近修改日 */
dzvk012       varchar2(40)      /* 客户代号 */
);
alter table dzvk_t add constraint dzvk_pk primary key (dzvk001,dzvk002,dzvk003,dzvk004) enable validate;


grant select on dzvk_t to tiptop;
grant update on dzvk_t to tiptop;
grant delete on dzvk_t to tiptop;
grant insert on dzvk_t to tiptop;

exit;
