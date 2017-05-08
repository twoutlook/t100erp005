/* 
================================================================================
檔案代號:wseu_t
檔案名稱:集成产品参数编号表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wseu_t
(
wseu001       varchar2(10)      ,/* 参数编号 */
wseu002       varchar2(80)      ,/* 字段名称 */
wseu003       varchar2(10)      ,/* 产品别 */
wseuownid       varchar2(20)      ,/* 资料所有者 */
wseuowndp       varchar2(10)      ,/* 资料所有部门 */
wseucrtid       varchar2(20)      ,/* 资料录入者 */
wseucrtdp       varchar2(10)      ,/* 资料录入部门 */
wseucrtdt       timestamp(0)      ,/* 资料创建日 */
wseumodid       varchar2(20)      ,/* 资料更改者 */
wseumoddt       timestamp(0)      /* 最近更改日 */
);
alter table wseu_t add constraint wseu_pk primary key (wseu001,wseu003) enable validate;

create unique index wseu_pk on wseu_t (wseu001,wseu003);

grant select on wseu_t to tiptop;
grant update on wseu_t to tiptop;
grant delete on wseu_t to tiptop;
grant insert on wseu_t to tiptop;

exit;
