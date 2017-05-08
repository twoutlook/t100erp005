/* 
================================================================================
檔案代號:stge_t
檔案名稱:專櫃銷售成本月匯總統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table stge_t
(
stgeent       number(5)      ,/* 企業編號 */
stgesite       varchar2(10)      ,/* 營運組織 */
stgeunit       varchar2(10)      ,/* 應用組織 */
stge001       varchar2(6)      ,/* 會計期間 */
stge002       varchar2(20)      ,/* 專櫃編號 */
stge003       varchar2(10)      ,/* 供應商編號 */
stge004       varchar2(10)      ,/* 樓層編號 */
stge005       varchar2(10)      ,/* 經營小類編號 */
stge006       varchar2(10)      ,/* 經營方式 */
stge007       number(15,3)      ,/* 專櫃面積 */
stge008       number(15,3)      ,/* 追溯面積 */
stge009       number(20,6)      ,/* 原價金額 */
stge010       number(20,6)      ,/* 實收金額 */
stge011       number(20,6)      ,/* 應付成本 */
stge012       number(20,6)      ,/* 預扣費用金額 */
stge013       number(20,6)      ,/* 保底成本差額 */
stge014       number(20,6)      ,/* 目標銷售成本差額 */
stge015       number(20,6)      ,/* 稅額 */
stge016       number(20,6)      ,/* 費用扣項金額 */
stge017       number(20,6)      ,/* 租金 */
stge018       number(20,6)      ,/* 物業管理費 */
stge019       number(20,6)      ,/* 返還VIP折扣 */
stge020       number(20,6)      ,/* 結算調整金額 */
stge021       number(20,6)      ,/* 退貨調整金額 */
stge022       number(20,6)      /* 加抽/降扣金额 */
);
alter table stge_t add constraint stge_pk primary key (stgeent,stgesite,stge001,stge002) enable validate;

create unique index stge_pk on stge_t (stgeent,stgesite,stge001,stge002);

grant select on stge_t to tiptop;
grant update on stge_t to tiptop;
grant delete on stge_t to tiptop;
grant insert on stge_t to tiptop;

exit;
