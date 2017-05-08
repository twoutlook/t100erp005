/* 
================================================================================
檔案代號:dzbk_t
檔案名稱:差异比对Patch编号条件设置
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzbk_t
(
dzbk001       varchar2(500)      ,/* Patch编号 */
dzbk002       varchar2(10)      ,/* no use */
dzbk003       varchar2(10)      ,/* no use */
dzbkownid       varchar2(20)      ,/* 数据所有者 */
dzbkowndp       varchar2(10)      ,/* 数据所属部门 */
dzbkcrtid       varchar2(20)      ,/* 数据录入者 */
dzbkcrtdp       varchar2(10)      ,/* 数据录入部门 */
dzbkcrtdt       timestamp(0)      ,/* 数据创建日 */
dzbkmodid       varchar2(20)      ,/* 数据更改者 */
dzbkmoddt       timestamp(0)      /* 最近更改日 */
);


grant select on dzbk_t to tiptop;
grant update on dzbk_t to tiptop;
grant delete on dzbk_t to tiptop;
grant insert on dzbk_t to tiptop;

exit;
