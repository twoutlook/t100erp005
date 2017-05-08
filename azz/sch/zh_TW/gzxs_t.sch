/* 
================================================================================
檔案代號:gzxs_t
檔案名稱:用户集成相关需求信息注册表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzxs_t
(
gzxsent       number(5)      ,/* 企业代码 */
gzxs001       varchar2(20)      ,/* 用户帐号 */
gzxs002       varchar2(80)      /* 用户个人串接外部需要额外参数部分 */
);
alter table gzxs_t add constraint gzxs_pk primary key (gzxsent,gzxs001) enable validate;

create unique index gzxs_pk on gzxs_t (gzxsent,gzxs001);

grant select on gzxs_t to tiptop;
grant update on gzxs_t to tiptop;
grant delete on gzxs_t to tiptop;
grant insert on gzxs_t to tiptop;

exit;
