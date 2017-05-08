/* 
================================================================================
檔案代號:stgf_t
檔案名稱:專櫃每日促銷銷售情況統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table stgf_t
(
stgfent       number(5)      ,/* 企業編號 */
stgfsite       varchar2(10)      ,/* 營運組織 */
stgfunit       varchar2(10)      ,/* 應用組織 */
stgf001       date      ,/* 促銷日期 */
stgf002       varchar2(40)      ,/* 商品編號 */
stgf003       varchar2(10)      ,/* 庫區編號 */
stgf004       varchar2(10)      ,/* 專櫃編號 */
stgf005       varchar2(10)      ,/* 供應商編號 */
stgf006       varchar2(10)      ,/* 樓層編號 */
stgf007       varchar2(10)      ,/* 經營小類編號 */
stgf008       number(20,6)      ,/* 加抽/降扣率 */
stgf009       number(20,6)      ,/* 銷售數量 */
stgf010       number(20,6)      ,/* 原價金額 */
stgf011       number(20,6)      ,/* 實收金額 */
stgf012       number(20,6)      ,/* 加抽降扣金額 */
stgf013       varchar2(10)      ,/* 管理品類 */
stgf014       varchar2(10)      ,/* 促銷方式 */
stgf015       varchar2(10)      ,/* 促銷類型 */
stgf016       varchar2(10)      ,/* 活動類型 */
stgf017       varchar2(10)      ,/* 活動力度 */
stgf018       number(20,6)      /* 成本金額 */
);
alter table stgf_t add constraint stgf_pk primary key (stgfent,stgfsite,stgf001,stgf002,stgf003) enable validate;

create unique index stgf_pk on stgf_t (stgfent,stgfsite,stgf001,stgf002,stgf003);

grant select on stgf_t to tiptop;
grant update on stgf_t to tiptop;
grant delete on stgf_t to tiptop;
grant insert on stgf_t to tiptop;

exit;
