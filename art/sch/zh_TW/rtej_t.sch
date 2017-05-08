/* 
================================================================================
檔案代號:rtej_t
檔案名稱:商品組成用量解析檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtej_t
(
rtejent       number(5)      ,/* 企業編號 */
rtej001       date      ,/* 執行日期 */
rtej002       varchar2(40)      ,/* 商品編號 */
rtej003       varchar2(10)      ,/* 商品單位 */
rtej004       varchar2(40)      ,/* 上階商品編號 */
rtej005       varchar2(10)      ,/* 上階商品單位 */
rtej006       varchar2(40)      ,/* 最上階商品編號 */
rtej007       varchar2(10)      ,/* 最上階商品單位 */
rtej008       number(20,6)      ,/* 與最上階商品間轉換率 */
rtej009       varchar2(1)      /* 最底層否 */
);
alter table rtej_t add constraint rtej_pk primary key (rtejent,rtej001,rtej002,rtej004,rtej006) enable validate;

create unique index rtej_pk on rtej_t (rtejent,rtej001,rtej002,rtej004,rtej006);

grant select on rtej_t to tiptop;
grant update on rtej_t to tiptop;
grant delete on rtej_t to tiptop;
grant insert on rtej_t to tiptop;

exit;
