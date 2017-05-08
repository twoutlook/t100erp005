/* 
================================================================================
檔案代號:wset_t
檔案名稱:集成产品参数表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wset_t
(
wsetent       number(5)      ,/* 企业编号 */
wset001       varchar2(40)      ,/* 参数编号 */
wset002       varchar2(100)      ,/* 参数数据 */
wset003       varchar2(1)      ,/* 全域否 */
wsetownid       varchar2(20)      ,/* 资料所有者 */
wsetowndp       varchar2(10)      ,/* 资料所有部门 */
wsetcrtid       varchar2(20)      ,/* 资料录入者 */
wsetcrtdp       varchar2(10)      ,/* 资料录入部门 */
wsetcrtdt       date      ,/* 资料创建日 */
wsetmodid       varchar2(20)      ,/* 资料更改者 */
wsetmoddt       date      /* 最近更改日 */
);
alter table wset_t add constraint wset_pk primary key (wsetent,wset001) enable validate;

create unique index wset_pk on wset_t (wsetent,wset001);

grant select on wset_t to tiptop;
grant update on wset_t to tiptop;
grant delete on wset_t to tiptop;
grant insert on wset_t to tiptop;

exit;
