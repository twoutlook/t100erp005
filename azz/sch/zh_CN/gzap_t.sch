/* 
================================================================================
檔案代號:gzap_t
檔案名稱:开账设置应用元件/校验传入参数档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzap_t
(
gzap001       varchar2(15)      ,/* 作业编号 */
gzap002       varchar2(10)      ,/* 格式编号 */
gzap003       varchar2(15)      ,/* 表格编号 */
gzap004       varchar2(20)      ,/* 字段编号 */
gzap005       number(10,0)      ,/* 顺序 */
gzap006       varchar2(500)      ,/* 传入值 */
gzap007       varchar2(255)      ,/* 备注 */
gzap008       varchar2(1)      ,/* 为JSON */
gzap009       varchar2(1)      /* 为动态字段 */
);
alter table gzap_t add constraint gzap_pk primary key (gzap001,gzap002,gzap003,gzap004,gzap005) enable validate;

create unique index gzap_pk on gzap_t (gzap001,gzap002,gzap003,gzap004,gzap005);

grant select on gzap_t to tiptop;
grant update on gzap_t to tiptop;
grant delete on gzap_t to tiptop;
grant insert on gzap_t to tiptop;

exit;
