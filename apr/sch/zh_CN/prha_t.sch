/* 
================================================================================
檔案代號:prha_t
檔案名稱:促銷協議單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prha_t
(
prhaent       number(5)      ,/* 企業編號 */
prhadocdt       date      ,/* 單據日期 */
prhaownid       varchar2(20)      ,/* 資料所屬者 */
prhadocno       varchar2(20)      ,/* 單號 */
prhaowndp       varchar2(10)      ,/* 資料所屬部門 */
prhacrtid       varchar2(20)      ,/*   */
prhasite       varchar2(10)      ,/* 營運據點 */
prhacrtdp       varchar2(10)      ,/*   */
prhacrtdt       timestamp(0)      ,/* 資料創建日 */
prhamodid       varchar2(20)      ,/*   */
prhamoddt       timestamp(0)      ,/*   */
prhacnfid       varchar2(20)      ,/*   */
prhacnfdt       timestamp(0)      ,/*   */
prhapstid       varchar2(20)      ,/* 資料過帳者 */
prhapstdt       timestamp(0)      ,/* 資料過帳日 */
prhastus       varchar2(10)      ,/* 狀態碼 */
prha001       varchar2(255)      ,/* 備註 */
prhaunit       varchar2(10)      /* 制定組織 */
);
alter table prha_t add constraint prha_pk primary key (prhaent,prhadocno) enable validate;

create unique index prha_pk on prha_t (prhaent,prhadocno);

grant select on prha_t to tiptop;
grant update on prha_t to tiptop;
grant delete on prha_t to tiptop;
grant insert on prha_t to tiptop;

exit;
