/* 
================================================================================
檔案代號:gzwi_t
檔案名稱:問題反映記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzwi_t
(
gzwiownid       varchar2(20)      ,/* 資料所有者 */
gzwiowndp       varchar2(10)      ,/* 資料所屬部門 */
gzwicrtid       varchar2(20)      ,/* 資料建立者 */
gzwicrtdp       varchar2(10)      ,/* 資料建立部門 */
gzwicrtdt       timestamp(0)      ,/* 資料創建日 */
gzwimodid       varchar2(20)      ,/* 資料修改者 */
gzwimoddt       timestamp(0)      ,/* 最近修改日 */
gzwistus       varchar2(10)      ,/* 狀態碼 */
gzwi001       varchar2(20)      ,/* 問題編號 */
gzwi002       varchar2(10)      ,/* 問題分類 */
gzwi003       varchar2(4)      ,/* 模組 */
gzwi004       varchar2(4000)      ,/* 問題描述 */
gzwi005       varchar2(20)      ,/* 反映人員 */
gzwi006       varchar2(10)      ,/* 反映營運據點 */
gzwi007       varchar2(20)      ,/* 處理人員 */
gzwi008       varchar2(20)      ,/* 作業編號 */
gzwi009       varchar2(20)      ,/* 案件代號 */
gzwi010       varchar2(1)      ,/* 緊急案件 */
gzwi011       varchar2(10)      ,/* 處理狀態 */
gzwi012       varchar2(4000)      ,/* 更新摘要 */
gzwi013       timestamp(0)      ,/* 反映日期 */
gzwi014       varchar2(10)      ,/* 負責單位 */
gzwi015       varchar2(10)      ,/* 處理人員類型 */
gzwi016       number(5,0)      ,/* 流水號 */
gzwi017       number(5)      ,/* 企業編號 */
gzwi018       varchar2(20)      ,/* 處理人員 */
gzwi019       date      ,/* 規格預計完成日 */
gzwi020       date      ,/* 規格實際完成日 */
gzwi021       date      ,/* 預計完成日 */
gzwi022       date      ,/* 實際完成日 */
gzwi023       number(15,3)      ,/* 預估時數 */
gzwi024       number(15,3)      ,/* 實際時數 */
gzwi025       varchar2(20)      ,/* 確認書編號 */
gzwi026       timestamp(0)      ,/* 最近同步時間 */
gzwi027       varchar2(4000)      ,/* 案件歷程 */
gzwi028       varchar2(20)      /* 客戶代號 */
);
alter table gzwi_t add constraint gzwi_pk primary key (gzwi001) enable validate;

create unique index gzwi_pk on gzwi_t (gzwi001);

grant select on gzwi_t to tiptop;
grant update on gzwi_t to tiptop;
grant delete on gzwi_t to tiptop;
grant insert on gzwi_t to tiptop;

exit;
