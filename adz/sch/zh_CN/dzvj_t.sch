/* 
================================================================================
檔案代號:dzvj_t
檔案名稱:字段数据多语言设计表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvj_t
(
dzvjstus       varchar2(10)      ,/* no use */
dzvj001       varchar2(20)      ,/* 规格编号 */
dzvj002       varchar2(60)      ,/* 控件编号 */
dzvj003       varchar2(15)      ,/* 识别码版次 */
dzvj004       varchar2(1)      ,/* 使用标示 */
dzvj005       varchar2(60)      ,/* 依附控件编号 */
dzvj007       varchar2(80)      ,/* 对应传值设置 */
dzvj008       varchar2(15)      ,/* 多语言Table */
dzvj009       varchar2(80)      ,/* 多语言FK */
dzvj010       varchar2(20)      ,/* 多语言语系 */
dzvj011       varchar2(20)      ,/* 多语言回传 */
dzvjownid       varchar2(10)      ,/* 资料所有者 */
dzvjowndp       varchar2(10)      ,/* 资料所有部门 */
dzvjcrtid       varchar2(10)      ,/* 资料建立者 */
dzvjcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvjcrtdt       date      ,/* 资料创建日 */
dzvjmodid       varchar2(10)      ,/* 资料修改者 */
dzvjmoddt       date      ,/* 最近修改日 */
dzvj099       clob      ,/* 规格描述 */
dzvj012       varchar2(40)      /* 客户代号 */
);
alter table dzvj_t add constraint dzvj_pk primary key (dzvj001,dzvj002,dzvj003,dzvj004) enable validate;


grant select on dzvj_t to tiptop;
grant update on dzvj_t to tiptop;
grant delete on dzvj_t to tiptop;
grant insert on dzvj_t to tiptop;

exit;
