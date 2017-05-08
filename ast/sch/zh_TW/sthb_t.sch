/* 
================================================================================
檔案代號:sthb_t
檔案名稱:合約費用項設定單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sthb_t
(
sthbent       number(5)      ,/*   */
sthbunit       varchar2(10)      ,/*   */
sthbsite       varchar2(10)      ,/* 營運據點 */
sthb001       varchar2(10)      ,/* 方案編號 */
sthb002       varchar2(10)      ,/* 費用編號 */
sthb003       varchar2(10)      ,/* 結算方式 */
sthb004       varchar2(10)      ,/* 日核算演算法 */
sthb005       varchar2(10)      ,/* 核算制度 */
sthb006       varchar2(10)      ,/* 標准否 */
sthb007       number(5,0)      ,/* 出帳期 */
sthb008       number(5,0)      ,/* 出帳日 */
sthbud001       varchar2(40)      ,/*   */
sthbud002       varchar2(40)      ,/*   */
sthbud003       varchar2(40)      ,/*   */
sthbud004       varchar2(40)      ,/*   */
sthbud005       varchar2(40)      ,/*   */
sthbud006       varchar2(40)      ,/*   */
sthbud007       varchar2(40)      ,/*   */
sthbud008       varchar2(40)      ,/*   */
sthbud009       varchar2(40)      ,/*   */
sthbud010       varchar2(40)      ,/*   */
sthbud011       number(20,6)      ,/*   */
sthbud012       number(20,6)      ,/*   */
sthbud013       number(20,6)      ,/*   */
sthbud014       number(20,6)      ,/*   */
sthbud015       number(20,6)      ,/*   */
sthbud016       number(20,6)      ,/*   */
sthbud017       number(20,6)      ,/*   */
sthbud018       number(20,6)      ,/*   */
sthbud019       number(20,6)      ,/*   */
sthbud020       number(20,6)      ,/*   */
sthbud021       timestamp(0)      ,/*   */
sthbud022       timestamp(0)      ,/*   */
sthbud023       timestamp(0)      ,/*   */
sthbud024       timestamp(0)      ,/*   */
sthbud025       timestamp(0)      ,/*   */
sthbud026       timestamp(0)      ,/*   */
sthbud027       timestamp(0)      ,/*   */
sthbud028       timestamp(0)      ,/*   */
sthbud029       timestamp(0)      ,/*   */
sthbud030       timestamp(0)      ,/*   */
sthb009       varchar2(10)      ,/* 費用歸屬類型 */
sthb010       varchar2(10)      ,/* 費用歸屬組織 */
sthb011       varchar2(1)      ,/* 費用是否可以延期 */
sthb012       varchar2(10)      /* 稅別 */
);
alter table sthb_t add constraint sthb_pk primary key (sthbent,sthb001,sthb002) enable validate;

create unique index sthb_pk on sthb_t (sthbent,sthb001,sthb002);

grant select on sthb_t to tiptop;
grant update on sthb_t to tiptop;
grant delete on sthb_t to tiptop;
grant insert on sthb_t to tiptop;

exit;
