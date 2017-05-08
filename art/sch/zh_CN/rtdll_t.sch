/* 
================================================================================
檔案代號:rtdll_t
檔案名稱:備用品牌資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table rtdll_t
(
rtdllent       number(5)      ,/* 企業編號 */
rtdll001       varchar2(10)      ,/* 品牌編號 */
rtdll002       varchar2(6)      ,/* 語言別 */
rtdll003       varchar2(500)      ,/* 說明 */
rtdll004       varchar2(10)      /* 助記碼 */
);
alter table rtdll_t add constraint rtdll_pk primary key (rtdllent,rtdll001,rtdll002) enable validate;

create unique index rtdll_pk on rtdll_t (rtdllent,rtdll001,rtdll002);

grant select on rtdll_t to tiptop;
grant update on rtdll_t to tiptop;
grant delete on rtdll_t to tiptop;
grant insert on rtdll_t to tiptop;

exit;
