/* 
================================================================================
檔案代號:dzzg_t
檔案名稱:签核等级单头(测试用)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzzg_t
(
dzzgstus       varchar2(10)      ,/* 状态码 */
dzzg001              ,/* 签核等级 */
dzzg002       varchar2(80)      ,/* 说明 */
dzzg003       varchar2(80)      ,/* 说明 */
dzzg004       varchar2(10)      ,/* ComboBox(改属性) */
dzzg005       varchar2(10)      ,/* ButtonEdit字段(改属性) */
dzzg006       date      ,/* 日期字段(改属性) */
dzzg007       varchar2(1)      ,/* 是否需查看后方可签核 */
dzzg008       varchar2(1)      ,/* 是否由系统自动赋予签核等级 */
dzzg009       varchar2(10)      ,/* 签核单据别 */
dzzg010       varchar2(80)      ,/* 赋予条件 */
dzzg011       varchar2(10)      ,/* 换为人员代号 */
dzzgownid       varchar2(10)      ,/* 资料所有者 */
dzzgowndp       varchar2(10)      ,/* 资料所有部门 */
dzzgcrtid       varchar2(10)      ,/* 资料建立者 */
dzzgcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzzgcrtdt       date      ,/* 资料创建日 */
dzzgmodid       varchar2(10)      ,/* 资料修改者 */
dzzgmoddt       date      ,/* 最近修改日 */
dzzgcnfid       varchar2(10)      ,/* 资料确认者 */
dzzgcnfdt       date      /* 数据确认日 */
);
alter table dzzg_t add constraint dzzg_pk primary key (dzzg001) enable validate;


grant select on dzzg_t to tiptop;
grant update on dzzg_t to tiptop;
grant delete on dzzg_t to tiptop;
grant insert on dzzg_t to tiptop;

exit;
