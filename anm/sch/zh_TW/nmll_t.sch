/* 
================================================================================
檔案代號:nmll_t
檔案名稱:银行账户用户设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmll_t
(
nmllent       number(5)      ,/* 企业编号 */
nmllownid       varchar2(20)      ,/* 资料所有者 */
nmllowndp       varchar2(10)      ,/* 资料所有部门 */
nmllcrtid       varchar2(20)      ,/* 资料录入者 */
nmllcrtdp       varchar2(10)      ,/* 资料录入部门 */
nmllcrtdt       timestamp(0)      ,/* 资料创建日 */
nmllmodid       varchar2(20)      ,/* 资料更改者 */
nmllmoddt       timestamp(0)      ,/* 最近更改日 */
nmllstus       varchar2(10)      ,/* 状态码 */
nmllcomp       varchar2(10)      ,/* 法人 */
nmllsite       varchar2(10)      ,/* 营运据点 */
nmll001       varchar2(10)      ,/* 交易帐户编号 */
nmll002       varchar2(20)      /* 用户编号 */
);
alter table nmll_t add constraint nmll_pk primary key (nmllent,nmll001,nmll002) enable validate;

create unique index nmll_pk on nmll_t (nmllent,nmll001,nmll002);

grant select on nmll_t to tiptop;
grant update on nmll_t to tiptop;
grant delete on nmll_t to tiptop;
grant insert on nmll_t to tiptop;

exit;
