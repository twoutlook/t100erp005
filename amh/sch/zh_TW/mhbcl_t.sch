/* 
================================================================================
檔案代號:mhbcl_t
檔案名稱:鋪位申請資料表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mhbcl_t
(
mhbclent       number(5)      ,/* 企業編號 */
mhbcldocno       varchar2(20)      ,/* 單據編號 */
mhbcl001       varchar2(20)      ,/* 鋪位編號 */
mhbcl002       varchar2(6)      ,/* 語言別 */
mhbcl003       varchar2(500)      ,/* 說明 */
mhbcl004       varchar2(10)      /* 助記碼 */
);
alter table mhbcl_t add constraint mhbcl_pk primary key (mhbclent,mhbcldocno,mhbcl001,mhbcl002) enable validate;

create unique index mhbcl_pk on mhbcl_t (mhbclent,mhbcldocno,mhbcl001,mhbcl002);

grant select on mhbcl_t to tiptop;
grant update on mhbcl_t to tiptop;
grant delete on mhbcl_t to tiptop;
grant insert on mhbcl_t to tiptop;

exit;
