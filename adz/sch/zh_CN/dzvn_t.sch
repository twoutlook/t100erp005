/* 
================================================================================
檔案代號:dzvn_t
檔案名稱:代码与内容版本对应表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvn_t
(
dzvnstus       varchar2(10)      ,/* 状态码 */
dzvn001       varchar2(20)      ,/* 代码编号 */
dzvn002       varchar2(15)      ,/* 代码版次 */
dzvn003       varchar2(60)      ,/* 代码设计点 */
dzvn004       varchar2(15)      ,/* 设计点版次 */
dzvn005       varchar2(1)      ,/* 使用标示 */
dzvnownid       varchar2(10)      ,/* 资料所有者 */
dzvnowndp       varchar2(10)      ,/* 资料所有部门 */
dzvncrtid       varchar2(10)      ,/* 资料建立者 */
dzvncrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvncrtdt       date      ,/* 资料创建日 */
dzvnmodid       varchar2(10)      ,/* 资料修改者 */
dzvnmoddt       date      ,/* 最近修改日 */
dzvn006       number(5,0)      ,/* 函式顺序 */
dzvn007       varchar2(1)      ,/* 程序引用否 */
dzvn008       varchar2(20)      ,/* 产品版本 */
dzvn009       varchar2(1)      ,/* 下方的硬结构代码整段注解 */
dzvn010       varchar2(1)      ,/* 客制标示 */
dzvn011       varchar2(40)      /* 客户代号 */
);
alter table dzvn_t add constraint dzvn_pk primary key (dzvn001,dzvn002,dzvn003,dzvn010) enable validate;


grant select on dzvn_t to tiptop;
grant update on dzvn_t to tiptop;
grant delete on dzvn_t to tiptop;
grant insert on dzvn_t to tiptop;

exit;
