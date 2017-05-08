/* 
================================================================================
檔案代號:gzxl_t
檔案名稱:AD主机注册表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzxl_t
(
gzxl001       varchar2(80)      ,/* 短 domain */
gzxl002       varchar2(80)      ,/* 长 domain */
gzxl003       varchar2(40)      ,/* ip+port */
gzxlownid       varchar2(20)      ,/* 资料所有者 */
gzxlowndp       varchar2(10)      ,/* 资料所有部门 */
gzxlcrtid       varchar2(20)      ,/* 资料录入者 */
gzxlcrtdp       varchar2(10)      ,/* 资料录入部门 */
gzxlcrtdt       timestamp(0)      ,/* 资料创建日 */
gzxlmodid       varchar2(20)      ,/* 资料更改者 */
gzxlmoddt       timestamp(0)      ,/* 最近更改日 */
gzxl004       varchar2(10)      /* 主机类型 */
);
alter table gzxl_t add constraint gzxl_pk primary key (gzxl001) enable validate;

create unique index gzxl_pk on gzxl_t (gzxl001);

grant select on gzxl_t to tiptop;
grant update on gzxl_t to tiptop;
grant delete on gzxl_t to tiptop;
grant insert on gzxl_t to tiptop;

exit;
