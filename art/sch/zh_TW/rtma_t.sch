/* 
================================================================================
檔案代號:rtma_t
檔案名稱:价签打印明细导入档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtma_t
(
rtmaent       number(5)      ,/* 企業代碼 */
rtmadocno       varchar2(20)      ,/* 單號 */
rtmaseq       number(10,0)      ,/* 項次 */
rtma001       number(20,6)      ,/* 列印數量 */
rtma002       varchar2(1)      ,/* 價格選項 */
rtma003       varchar2(40)      ,/* 商品編號 */
rtma004       varchar2(40)      ,/* 商品條碼 */
rtma005       varchar2(10)      ,/* 主供應商 */
rtma006       varchar2(10)      ,/* 商品品類 */
rtma007       varchar2(10)      ,/* 商品品牌 */
rtma008       varchar2(80)      ,/* 產地 */
rtma009       varchar2(10)      ,/* 銷售單位 */
rtma010       number(20,6)      ,/* 售價 */
rtma011       number(20,6)      ,/* 門店會員價1 */
rtma012       number(20,6)      ,/* 門店會員價2 */
rtma013       number(20,6)      ,/* 門店會員價3 */
rtma014       date      ,/* 促銷售價開始時間 */
rtma015       date      ,/* 促銷售價結束時間 */
rtma016       number(20,6)      ,/* 促銷原價 */
rtma017       number(20,6)      ,/* 促銷售價 */
rtma018       number(20,6)      ,/* 促銷會員價1 */
rtma019       number(20,6)      ,/* 促銷會員價2 */
rtma020       number(20,6)      ,/* 促銷會員價3 */
rtma021       number(20,6)      ,/* 執行價 */
rtmastus       varchar2(10)      /* 狀態碼 */
);
alter table rtma_t add constraint rtma_pk primary key (rtmaent,rtmadocno,rtmaseq) enable validate;

create unique index rtma_pk on rtma_t (rtmaent,rtmadocno,rtmaseq);

grant select on rtma_t to tiptop;
grant update on rtma_t to tiptop;
grant delete on rtma_t to tiptop;
grant insert on rtma_t to tiptop;

exit;
