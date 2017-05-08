/* 
================================================================================
檔案代號:dzzh_t
檔案名稱:签核等级单身(测试用)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzzh_t
(
dzzhstus       varchar2(10)      ,/* 状态码 */
dzzh001              ,/* 签核等级 */
dzzh002       number(5,0)      ,/* 顺序 */
dzzh003       varchar2(10)      ,/* 人员代码 */
dzzh004       varchar2(500)      ,/* 备注 */
dzzh005       varchar2(10)      ,/* 人员签名档 */
dzzh006       varchar2(20)      ,/* dzzh006_test */
dzzh007       varchar2(20)      ,/* dzzh007_test */
dzzh008       date      ,/* dzzh008_test */
dzzhownid       varchar2(10)      ,/* 资料所有者 */
dzzhowndp       varchar2(10)      ,/* 资料所有部门 */
dzzhcrtid       varchar2(10)      ,/* 资料建立者 */
dzzhcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzzhcrtdt       date      ,/* 资料创建日 */
dzzhmodid       varchar2(10)      ,/* 资料修改者 */
dzzhmoddt       date      ,/* 最近修改日 */
dzzhcnfid       varchar2(10)      ,/* 资料确认者 */
dzzhcnfdt       date      /* 数据确认日 */
);
alter table dzzh_t add constraint dzzh_pk primary key (dzzh001,dzzh002,dzzh003) enable validate;


grant select on dzzh_t to tiptop;
grant update on dzzh_t to tiptop;
grant delete on dzzh_t to tiptop;
grant insert on dzzh_t to tiptop;

exit;
