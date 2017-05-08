/* 
================================================================================
檔案代號:gldo_t
檔案名稱:合併報表匯率資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table gldo_t
(
gldoent       number(5)      ,/* 企業編號 */
gldo001       number(5,0)      ,/* 年度 */
gldo002       number(5,0)      ,/* 期別 */
gldo003       varchar2(10)      ,/* 來源幣別 */
gldo004       varchar2(10)      ,/* 轉換幣別 */
gldo005       number(20,10)      ,/* 現時匯率 */
gldo006       number(20,10)      ,/* 歷史匯率 */
gldo007       number(20,10)      ,/* 平均匯率 */
gldoownid       varchar2(20)      ,/* 資料所有者 */
gldoowndp       varchar2(10)      ,/* 資料所屬部門 */
gldocrtid       varchar2(20)      ,/* 資料建立者 */
gldocrtdp       varchar2(10)      ,/* 資料建立部門 */
gldocrtdt       timestamp(0)      ,/* 資料創建日 */
gldomodid       varchar2(20)      ,/* 資料修改者 */
gldomoddt       timestamp(0)      /* 最近修改日 */
);
alter table gldo_t add constraint gldo_pk primary key (gldoent,gldo001,gldo002,gldo003,gldo004) enable validate;

create unique index gldo_pk on gldo_t (gldoent,gldo001,gldo002,gldo003,gldo004);

grant select on gldo_t to tiptop;
grant update on gldo_t to tiptop;
grant delete on gldo_t to tiptop;
grant insert on gldo_t to tiptop;

exit;
