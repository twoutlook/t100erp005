/* 
================================================================================
檔案代號:stka_t
檔案名稱:促銷商戶費用分攤明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stka_t
(
stkaent       number(5)      ,/* 企業代碼 */
stkaunit       varchar2(10)      ,/* 應用執行組織物件 */
stkasite       varchar2(10)      ,/* 營運據點 */
stkadocno       varchar2(20)      ,/* 單號 */
stkaseq       number(10,0)      ,/* 項次 */
stka001       date      ,/* 分攤日期 */
stka002       varchar2(20)      ,/* 促銷協議編號 */
stka003       varchar2(10)      ,/* 促銷類型 */
stka004       varchar2(20)      ,/* 促銷規則編號 */
stka005       varchar2(10)      ,/* 商戶編號 */
stka006       varchar2(20)      ,/* 鋪位編號 */
stka007       varchar2(20)      ,/* 合約編號 */
stka008       number(20,6)      ,/* 贈品數量 */
stka009       number(20,6)      ,/* 贈品金額 */
stka010       varchar2(30)      ,/* 卡券編號 */
stka011       number(20,6)      /* 分攤金額 */
);
alter table stka_t add constraint stka_pk primary key (stkaent,stkadocno,stkaseq) enable validate;

create unique index stka_pk on stka_t (stkaent,stkadocno,stkaseq);

grant select on stka_t to tiptop;
grant update on stka_t to tiptop;
grant delete on stka_t to tiptop;
grant insert on stka_t to tiptop;

exit;
