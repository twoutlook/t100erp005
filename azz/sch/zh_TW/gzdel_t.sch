/* 
================================================================================
檔案代號:gzdel_t
檔案名稱:子程序及应用元件基本数据表多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gzdel_t
(
gzdel001       varchar2(20)      ,/* 规格编号 */
gzdel002       varchar2(6)      ,/* 语言别 */
gzdel003       varchar2(500)      ,/* 说明 */
gzdel004       varchar2(10)      ,/* 助记码 */
gzdel005       varchar2(1)      /* 客制 */
);
alter table gzdel_t add constraint gzdel_pk primary key (gzdel001,gzdel002) enable validate;

create unique index gzdel_pk on gzdel_t (gzdel001,gzdel002);

grant select on gzdel_t to tiptop;
grant update on gzdel_t to tiptop;
grant delete on gzdel_t to tiptop;
grant insert on gzdel_t to tiptop;

exit;
