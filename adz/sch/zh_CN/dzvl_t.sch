/* 
================================================================================
檔案代號:dzvl_t
檔案名稱:程序串查设计表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvl_t
(
dzvlstus       varchar2(10)      ,/* 状态码 */
dzvl001       varchar2(20)      ,/* 规格编号 */
dzvl002       varchar2(60)      ,/* 控件编号 */
dzvl003       varchar2(15)      ,/* 识别码版次 */
dzvl004       varchar2(1)      ,/* 使用标示 */
dzvl005       varchar2(60)      ,/* 依附控件编号 */
dzvl006       varchar2(255)      ,/* 程序参考设置 */
dzvlownid       varchar2(10)      ,/* 资料所有者 */
dzvlowndp       varchar2(10)      ,/* 资料所有部门 */
dzvlcrtid       varchar2(10)      ,/* 资料建立者 */
dzvlcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvlcrtdt       date      ,/* 资料创建日 */
dzvlmodid       varchar2(10)      ,/* 资料修改者 */
dzvlmoddt       date      ,/* 最近修改日 */
dzvl007       varchar2(1)      ,/* 串查型态 */
dzvl008       number(5,0)      ,/* 项次 */
dzvl009       varchar2(40)      /* 客户代号 */
);
alter table dzvl_t add constraint dzvl_pk primary key (dzvl001,dzvl002,dzvl003,dzvl004,dzvl008) enable validate;


grant select on dzvl_t to tiptop;
grant update on dzvl_t to tiptop;
grant delete on dzvl_t to tiptop;
grant insert on dzvl_t to tiptop;

exit;
