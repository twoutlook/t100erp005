/* 
================================================================================
檔案代號:infh_t
檔案名稱:商品上下架明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table infh_t
(
infhent       number(5)      ,/* 企業代碼 */
infhsite       varchar2(10)      ,/* 營運據點 */
infhunit       varchar2(10)      ,/* 應用組織 */
infhdocno       varchar2(20)      ,/* 單據編號 */
infhseq       number(10,0)      ,/* 項次 */
infh001       varchar2(40)      ,/* 商品編號 */
infh002       varchar2(40)      ,/* 商品條碼 */
infh003       varchar2(256)      ,/* 商品特征 */
infh004       varchar2(10)      ,/* 庫存單位 */
infh005       varchar2(10)      ,/* 來源貨架 */
infh006       varchar2(10)      ,/* 目標貨架 */
infh007       date      ,/* 有效期至 */
infh008       varchar2(10)      ,/* 到期貨架 */
infh009       varchar2(10)      ,/* 轉移狀態 */
infh010       number(20,6)      ,/* 系統建議數量 */
infh011       number(20,6)      ,/* 實際數量 */
infh012       varchar2(20)      ,/* 來源單號 */
infh013       number(10,0)      /* 來源項次 */
);
alter table infh_t add constraint infh_pk primary key (infhent,infhdocno,infhseq) enable validate;

create unique index infh_pk on infh_t (infhent,infhdocno,infhseq);

grant select on infh_t to tiptop;
grant update on infh_t to tiptop;
grant delete on infh_t to tiptop;
grant insert on infh_t to tiptop;

exit;
