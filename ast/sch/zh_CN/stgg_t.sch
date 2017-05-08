/* 
================================================================================
檔案代號:stgg_t
檔案名稱:專櫃每日促銷銷售情況檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table stgg_t
(
stggent       number(5)      ,/* 企業編號 */
stggsite       varchar2(10)      ,/* 營運組織 */
stggunit       varchar2(10)      ,/* 應用組織 */
stgg001       date      ,/* 促銷日期 */
stgg002       varchar2(10)      ,/* 庫區編號 */
stgg003       varchar2(10)      ,/* 專櫃編號 */
stgg004       varchar2(10)      ,/* 供應商編號 */
stgg005       varchar2(10)      ,/* 樓層編號 */
stgg006       varchar2(10)      ,/* 經營小類編號 */
stgg007       number(20,6)      ,/* 原價金額 */
stgg008       number(20,6)      ,/* 實收金額 */
stgg009       number(20,6)      ,/* 實收毛利額 */
stgg010       number(20,6)      ,/* 實收毛利率 */
stgg011       number(20,6)      ,/* 促銷讓利額 */
stgg012       number(20,6)      ,/* 促銷讓利率 */
stgg013       number(20,6)      ,/* VIP折扣金額 */
stgg014       number(20,6)      /* 租金金額 */
);
alter table stgg_t add constraint stgg_pk primary key (stggent,stggsite,stgg001,stgg002) enable validate;

create unique index stgg_pk on stgg_t (stggent,stggsite,stgg001,stgg002);

grant select on stgg_t to tiptop;
grant update on stgg_t to tiptop;
grant delete on stgg_t to tiptop;
grant insert on stgg_t to tiptop;

exit;
