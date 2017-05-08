/* 
================================================================================
檔案代號:ookb_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ookb_t
(
ookbent       number(5)      ,/* 企業編號 */
ookb001       varchar2(10)      ,/* 上層目錄編號 */
ookb002       varchar2(10)      ,/* 目錄編號 */
ookb003       number(5,0)      ,/* 顯示順序 */
ookb004       varchar2(1)      ,/* 節點形態 */
ookb005       varchar2(1)      ,/* 客製 */
ookbownid       varchar2(20)      ,/* 資料所屬者 */
ookbowndp       varchar2(10)      ,/* 資料所屬部門 */
ookbcrtid       varchar2(20)      ,/*   */
ookbcrtdp       varchar2(10)      ,/*   */
ookbcrtdt       timestamp(0)      ,/* 資料創建日 */
ookbmodid       varchar2(20)      ,/*   */
ookbmoddt       timestamp(0)      ,/*   */
ookbud001       varchar2(40)      ,/*   */
ookbud002       varchar2(40)      ,/*   */
ookbud003       varchar2(40)      ,/*   */
ookbud004       varchar2(40)      ,/*   */
ookbud005       varchar2(40)      ,/*   */
ookbud006       varchar2(40)      ,/*   */
ookbud007       varchar2(40)      ,/*   */
ookbud008       varchar2(40)      ,/*   */
ookbud009       varchar2(40)      ,/*   */
ookbud010       varchar2(40)      ,/*   */
ookbud011       number(20,6)      ,/*   */
ookbud012       number(20,6)      ,/*   */
ookbud013       number(20,6)      ,/*   */
ookbud014       number(20,6)      ,/*   */
ookbud015       number(20,6)      ,/*   */
ookbud016       number(20,6)      ,/*   */
ookbud017       number(20,6)      ,/*   */
ookbud018       number(20,6)      ,/*   */
ookbud019       number(20,6)      ,/*   */
ookbud020       number(20,6)      ,/*   */
ookbud021       timestamp(0)      ,/*   */
ookbud022       timestamp(0)      ,/*   */
ookbud023       timestamp(0)      ,/*   */
ookbud024       timestamp(0)      ,/*   */
ookbud025       timestamp(0)      ,/*   */
ookbud026       timestamp(0)      ,/*   */
ookbud027       timestamp(0)      ,/*   */
ookbud028       timestamp(0)      ,/*   */
ookbud029       timestamp(0)      ,/*   */
ookbud030       timestamp(0)      /*   */
);
alter table ookb_t add constraint ookb_pk primary key (ookbent,ookb001,ookb002) enable validate;

create unique index ookb_pk on ookb_t (ookbent,ookb001,ookb002);

grant select on ookb_t to tiptop;
grant update on ookb_t to tiptop;
grant delete on ookb_t to tiptop;
grant insert on ookb_t to tiptop;

exit;
