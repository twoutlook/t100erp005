/* 
================================================================================
檔案代號:gzwo_t
檔案名稱:問題反映記錄異動檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzwo_t
(
gzwoownid       varchar2(20)      ,/* 資料所有者 */
gzwoowndp       varchar2(10)      ,/* 資料所屬部門 */
gzwocrtid       varchar2(20)      ,/* 資料建立者 */
gzwocrtdp       varchar2(10)      ,/* 資料建立部門 */
gzwocrtdt       timestamp(0)      ,/* 資料創建日 */
gzwomodid       varchar2(20)      ,/* 資料修改者 */
gzwomoddt       timestamp(0)      ,/* 最近修改日 */
gzwostus       varchar2(10)      ,/* 狀態碼 */
gzwo001       varchar2(20)      ,/* 問題編號 */
gzwo002       varchar2(10)      ,/* 類別 */
gzwo003       varchar2(4)      ,/* 模組 */
gzwo004       varchar2(4000)      ,/* 問題描述 */
gzwo005       varchar2(20)      ,/* 反映人員 */
gzwo006       varchar2(10)      ,/* 反映營運據點 */
gzwo007       varchar2(20)      ,/* 處理人員 */
gzwo008       varchar2(20)      ,/* 作業編號 */
gzwo009       varchar2(20)      ,/* 案件代號 */
gzwo010       varchar2(1)      ,/* 緊急案件 */
gzwo011       varchar2(10)      ,/* 處理狀態 */
gzwo012       varchar2(4000)      ,/* 更新摘要 */
gzwo013       timestamp(0)      ,/* 反映日期 */
gzwo014       varchar2(10)      ,/* 負責單位 */
gzwo015       varchar2(10)      ,/* 處理人員類型 */
gzwo016       number(5,0)      ,/* 流水號 */
gzwo017       number(5)      ,/* 企業編號 */
gzwo018       varchar2(20)      ,/* 處理人員 */
gzwo019       date      ,/* 規格預計完成日 */
gzwo020       date      ,/* 規格實際完成日 */
gzwo021       date      ,/* 預計完成日 */
gzwo022       date      ,/* 實際完成日 */
gzwo023       number(15,3)      ,/* 預估時數 */
gzwo024       number(15,3)      ,/* 實際時數 */
gzwo025       varchar2(20)      ,/* 確認書編號 */
gzwoseq       number(10,0)      ,/* 項次 */
gzwo901       varchar2(10)      ,/* 異動指令 */
gzwo902       varchar2(500)      ,/* 異動欄位 */
gzwo026       timestamp(0)      ,/* 最近同步時間 */
gzwo027       varchar2(4000)      ,/* 案件歷程 */
gzwo028       varchar2(20)      /* 客戶代號 */
);
alter table gzwo_t add constraint gzwo_pk primary key (gzwo001,gzwoseq) enable validate;

create unique index gzwo_pk on gzwo_t (gzwo001,gzwoseq);

grant select on gzwo_t to tiptop;
grant update on gzwo_t to tiptop;
grant delete on gzwo_t to tiptop;
grant insert on gzwo_t to tiptop;

exit;
