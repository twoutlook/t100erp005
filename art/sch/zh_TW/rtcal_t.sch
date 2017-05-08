/* 
================================================================================
檔案代號:rtcal_t
檔案名稱:預算指標參數設定維護檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table rtcal_t
(
rtcalent       number(5)      ,/* 企業編號 */
rtcal001       varchar2(10)      ,/* 指標編號 */
rtcal002       varchar2(6)      ,/* 語言別 */
rtcal003       varchar2(500)      ,/* 說明 */
rtcal004       varchar2(10)      /* 助記碼 */
);
alter table rtcal_t add constraint rtcal_pk primary key (rtcalent,rtcal001,rtcal002) enable validate;

create unique index rtcal_pk on rtcal_t (rtcalent,rtcal001,rtcal002);

grant select on rtcal_t to tiptop;
grant update on rtcal_t to tiptop;
grant delete on rtcal_t to tiptop;
grant insert on rtcal_t to tiptop;

exit;
