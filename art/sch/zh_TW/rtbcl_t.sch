/* 
================================================================================
檔案代號:rtbcl_t
檔案名稱:門店資訊准入多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table rtbcl_t
(
rtbclent       number(5)      ,/* 企業編號 */
rtbcldocno       varchar2(20)      ,/* 申請單號 */
rtbcl001       varchar2(6)      ,/* 語言別 */
rtbcl002       varchar2(500)      ,/* 說明(簡稱) */
rtbcl003       varchar2(500)      ,/* 說明(對內全稱) */
rtbcl004       varchar2(10)      /* 助記碼 */
);
alter table rtbcl_t add constraint rtbcl_pk primary key (rtbclent,rtbcldocno,rtbcl001) enable validate;

create unique index rtbcl_pk on rtbcl_t (rtbclent,rtbcldocno,rtbcl001);

grant select on rtbcl_t to tiptop;
grant update on rtbcl_t to tiptop;
grant delete on rtbcl_t to tiptop;
grant insert on rtbcl_t to tiptop;

exit;
