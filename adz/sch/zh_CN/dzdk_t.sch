/* 
================================================================================
檔案代號:dzdk_t
檔案名稱:應用元件改名批量處理檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdk_t
(
dzdk001       varchar2(40)      ,/* 原應用元件代號 */
dzdk002       varchar2(40)      ,/* 新應用元件代號 */
dzdk003       varchar2(1)      ,/* 註冊信息更新方式 */
dzdk004       number(10,0)      ,/* 項次 */
dzdk005       varchar2(20)      ,/* 4gl代號 */
dzdk006       varchar2(20)      ,/* 修改者 */
dzdk007       timestamp(5)      ,/* 修改時間 */
dzdk008       varchar2(1)      /* 客制否 */
);
alter table dzdk_t add constraint dzdk_pk primary key (dzdk001,dzdk002,dzdk004) enable validate;

create unique index dzdk_pk on dzdk_t (dzdk001,dzdk002,dzdk004);

grant select on dzdk_t to tiptop;
grant update on dzdk_t to tiptop;
grant delete on dzdk_t to tiptop;
grant insert on dzdk_t to tiptop;

exit;
