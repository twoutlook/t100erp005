/* 
================================================================================
檔案代號:inbq_t
檔案名稱:可用庫存查詢條件設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inbq_t
(
inbqent       number(5)      ,/* 企業代碼 */
inbq001       number(10,0)      ,/* 順序 */
inbq002       varchar2(10)      ,/* 計算專案 */
inbq003       varchar2(1)      ,/* 計算加減項 */
inbqownid       varchar2(20)      ,/* 資料所屬者 */
inbqowndp       varchar2(10)      ,/* 資料所屬部門 */
inbqcrtid       varchar2(20)      ,/* 資料建立者 */
inbqcrtdp       varchar2(10)      ,/* 資料建立部分 */
inbqcrtdt       timestamp(0)      ,/* 資料創建日 */
inbqmodid       varchar2(20)      ,/* 資料修改者 */
inbqmoddt       timestamp(0)      ,/* 最近更改日 */
inbqud001       varchar2(40)      ,/*   */
inbqud002       varchar2(40)      ,/*   */
inbqud003       varchar2(40)      ,/*   */
inbqud004       varchar2(40)      ,/*   */
inbqud005       varchar2(40)      ,/*   */
inbqud006       varchar2(40)      ,/*   */
inbqud007       varchar2(40)      ,/*   */
inbqud008       varchar2(40)      ,/*   */
inbqud009       varchar2(40)      ,/*   */
inbqud010       varchar2(40)      ,/*   */
inbqud011       number(20,6)      ,/*   */
inbqud012       number(20,6)      ,/*   */
inbqud013       number(20,6)      ,/*   */
inbqud014       number(20,6)      ,/*   */
inbqud015       number(20,6)      ,/*   */
inbqud016       number(20,6)      ,/*   */
inbqud017       number(20,6)      ,/*   */
inbqud018       number(20,6)      ,/*   */
inbqud019       number(20,6)      ,/*   */
inbqud020       number(20,6)      ,/*   */
inbqud021       timestamp(0)      ,/*   */
inbqud022       timestamp(0)      ,/*   */
inbqud023       timestamp(0)      ,/*   */
inbqud024       timestamp(0)      ,/*   */
inbqud025       timestamp(0)      ,/*   */
inbqud026       timestamp(0)      ,/*   */
inbqud027       timestamp(0)      ,/*   */
inbqud028       timestamp(0)      ,/*   */
inbqud029       timestamp(0)      ,/*   */
inbqud030       timestamp(0)      /*   */
);
alter table inbq_t add constraint inbq_pk primary key (inbqent,inbq002) enable validate;

create unique index inbq_pk on inbq_t (inbqent,inbq002);

grant select on inbq_t to tiptop;
grant update on inbq_t to tiptop;
grant delete on inbq_t to tiptop;
grant insert on inbq_t to tiptop;

exit;
