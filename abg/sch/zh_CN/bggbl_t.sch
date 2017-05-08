/* 
================================================================================
檔案代號:bggbl_t
檔案名稱:工资方案数据档多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bggbl_t
(
bggblent       number(5)      ,/* 企业编号 */
bggbl001       varchar2(10)      ,/* 工资方案 */
bggbl002       varchar2(10)      ,/* 工资项目 */
bggbl003       varchar2(6)      ,/* 语言别 */
bggbl004       varchar2(500)      ,/* 说明 */
bggbl005       varchar2(10)      /* 助记码 */
);
alter table bggbl_t add constraint bggbl_pk primary key (bggblent,bggbl001,bggbl002,bggbl003) enable validate;

create unique index bggbl_pk on bggbl_t (bggblent,bggbl001,bggbl002,bggbl003);

grant select on bggbl_t to tiptop;
grant update on bggbl_t to tiptop;
grant delete on bggbl_t to tiptop;
grant insert on bggbl_t to tiptop;

exit;
