/* 
================================================================================
檔案代號:dzgn_t
檔案名稱:报表组件规格设计表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzgn_t
(
dzgn001       varchar2(20)      ,/* 报表组件代号 */
dzgn002       varchar2(15)      ,/* 版次 */
dzgn003       varchar2(1)      ,/* 使用标示 */
dzgn099       clob      ,/* 规格描述 */
dzgnownid       varchar2(10)      ,/* 资料所有者 */
dzgnowndp       varchar2(10)      ,/* 资料所有部门 */
dzgncrtid       varchar2(10)      ,/* 资料建立者 */
dzgncrtdp       varchar2(10)      ,/* 资料建立部门 */
dzgncrtdt       date      ,/* 资料创建日 */
dzgnmodid       varchar2(10)      ,/* 资料修改者 */
dzgnmoddt       date      ,/* 最近修改日 */
dzgnstus       varchar2(10)      /* 状态码 */
);
alter table dzgn_t add constraint dzgn_pk primary key (dzgn001,dzgn002,dzgn003) enable validate;


grant select on dzgn_t to tiptop;
grant update on dzgn_t to tiptop;
grant delete on dzgn_t to tiptop;
grant insert on dzgn_t to tiptop;

exit;
