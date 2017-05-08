/* 
================================================================================
檔案代號:bxed_t
檔案名稱:保稅單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bxed_t
(
bxedent       number(5)      ,/* 企業編號 */
bxedsite       varchar2(10)      ,/* 營運據點 */
bxeddocno       varchar2(20)      ,/* 保稅單號 */
bxedseq       number(10,0)      ,/* 項次 */
bxed001       varchar2(20)      ,/* 來源單號 */
bxed002       number(10,0)      ,/* 來源項次 */
bxed003       number(10,0)      ,/* 來源項序 */
bxed004       varchar2(40)      ,/* 料件編號 */
bxed005       varchar2(10)      ,/* 庫存單位 */
bxed006       number(20,6)      ,/* 數量 */
bxed007       number(20,6)      ,/* 本幣單價 */
bxed008       number(20,6)      ,/* 總金額 */
bxed009       varchar2(10)      ,/* 摺合原因代碼 */
bxed010       varchar2(20)      ,/* 廠內編號 */
bxed011       varchar2(10)      ,/* 庫位 */
bxed012       varchar2(10)      ,/* 異動單位 */
bxed013       number(20,6)      ,/* 異動數量 */
bxed014       varchar2(20)      ,/* 報單號碼 */
bxed015       date      ,/* 報單日期 */
bxed016       varchar2(20)      ,/* 受託加工訂單單號 */
bxed017       number(10,0)      ,/* 受託加工訂單項次 */
bxed018       number(10,0)      ,/* 受託加工訂單項序 */
bxed019       number(10,0)      ,/* 受託加工訂單分批序 */
bxed020       varchar2(255)      /* 備註 */
);
alter table bxed_t add constraint bxed_pk primary key (bxedent,bxeddocno,bxedseq) enable validate;

create unique index bxed_pk on bxed_t (bxedent,bxeddocno,bxedseq);

grant select on bxed_t to tiptop;
grant update on bxed_t to tiptop;
grant delete on bxed_t to tiptop;
grant insert on bxed_t to tiptop;

exit;
