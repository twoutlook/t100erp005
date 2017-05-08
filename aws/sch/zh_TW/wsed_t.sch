/* 
================================================================================
檔案代號:wsed_t
檔案名稱:中間庫商品價格差異表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsed_t
(
wsed001       varchar2(10)      ,/* 門店 */
wsed002       varchar2(40)      ,/* 商品編號 */
wsed003       varchar2(255)      ,/* 商品名稱 */
wsed004       varchar2(40)      ,/* 條碼 */
wsed005       number(20,6)      ,/* T100售價 */
wsed006       number(20,6)      ,/* POS售價 */
wsed007       number(20,6)      ,/* T100會員價1 */
wsed008       number(20,6)      ,/* POS會員價1 */
wsed009       number(20,6)      ,/* T100會員價2 */
wsed010       number(20,6)      ,/* POS會員價2 */
wsed011       number(20,6)      ,/* T100會員價3 */
wsed012       number(20,6)      ,/* POS會員價3 */
wsedent       number(5)      ,/* 企業代碼 */
wsed013       varchar2(10)      /* 單位 */
);
alter table wsed_t add constraint wsed_pk primary key (wsed001,wsed002,wsed004,wsedent,wsed013) enable validate;

create unique index wsed_pk on wsed_t (wsed001,wsed002,wsed004,wsedent,wsed013);

grant select on wsed_t to tiptop;
grant update on wsed_t to tiptop;
grant delete on wsed_t to tiptop;
grant insert on wsed_t to tiptop;

exit;
