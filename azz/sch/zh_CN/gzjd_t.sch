/* 
================================================================================
檔案代號:gzjd_t
檔案名稱:Client服务设置产品别数据表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzjd_t
(
gzjdstus       varchar2(10)      ,/* 状态码 */
gzjd001       varchar2(40)      ,/* WS服务名称 */
gzjd002       varchar2(40)      /* 产品别 */
);
alter table gzjd_t add constraint gzjd_pk primary key (gzjd001,gzjd002) enable validate;

create unique index gzjd_pk on gzjd_t (gzjd001,gzjd002);

grant select on gzjd_t to tiptop;
grant update on gzjd_t to tiptop;
grant delete on gzjd_t to tiptop;
grant insert on gzjd_t to tiptop;

exit;
