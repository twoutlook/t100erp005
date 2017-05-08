/* 
================================================================================
檔案代號:rtdal_t
檔案名稱:商品生命周期多语言表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table rtdal_t
(
rtdalent       number(5)      ,/* 企業代碼 */
rtdal001       varchar2(10)      ,/* 生命週期編號 */
rtdal002       varchar2(6)      ,/* 語言別 */
rtdal003       varchar2(500)      ,/* 說明 */
rtdal004       varchar2(10)      /* 助記碼 */
);
alter table rtdal_t add constraint rtdal_pk primary key (rtdalent,rtdal001,rtdal002) enable validate;

create unique index rtdal_pk on rtdal_t (rtdalent,rtdal001,rtdal002);

grant select on rtdal_t to tiptop;
grant update on rtdal_t to tiptop;
grant delete on rtdal_t to tiptop;
grant insert on rtdal_t to tiptop;

exit;
