/* 
================================================================================
檔案代號:wseul_t
檔案名稱:集成产品参数编号表多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table wseul_t
(
wseul001       varchar2(10)      ,/* 参数编号 */
wseul003       varchar2(10)      ,/* 产品别 */
wseul004       varchar2(6)      ,/* 语言别 */
wseul002       varchar2(80)      ,/* 字段名称 */
wseul006       varchar2(10)      /* 助记码 */
);
alter table wseul_t add constraint wseul_pk primary key (wseul001,wseul003,wseul004) enable validate;

create unique index wseul_pk on wseul_t (wseul001,wseul003,wseul004);

grant select on wseul_t to tiptop;
grant update on wseul_t to tiptop;
grant delete on wseul_t to tiptop;
grant insert on wseul_t to tiptop;

exit;
