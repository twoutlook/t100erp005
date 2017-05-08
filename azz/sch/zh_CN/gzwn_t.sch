/* 
================================================================================
檔案代號:gzwn_t
檔案名稱:執行紀錄刪除Log檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table gzwn_t
(
gzwndocno       varchar2(20)      ,/* 單號 */
gzwncrtid       varchar2(20)      ,/* 資料建立者 */
gzwncrtdt       timestamp(0)      ,/* 資料創建日 */
gzwn001       varchar2(20)      ,/* Session Key */
gzwn002       varchar2(20)      ,/* 使用者編號 */
gzwn003       varchar2(20)      ,/* 作業編號 */
gzwn004       timestamp(0)      ,/* 執行開始時間 */
gzwn005       varchar2(100)      ,/* 授權編號 */
gzwn006       varchar2(40)      ,/* 使用者IP */
gzwn007       varchar2(10)      ,/* 執行模式 */
gzwn008       varchar2(20)      ,/* PID */
gzwn009       varchar2(20)      ,/* 員工編號 */
gzwn010       varchar2(20)      ,/* 執行區域 */
gzwn011       varchar2(10)      ,/* 歸屬部門 */
gzwn012       number(5)      ,/* 企業代碼 */
gzwn013       varchar2(40)      ,/* WS產品來源 */
gzwn014       varchar2(1)      ,/* 背景作業 */
gzwn015       varchar2(20)      ,/* AP主機 */
gzwn099       varchar2(1)      /* 刪除方式 */
);
alter table gzwn_t add constraint gzwn_pk primary key (gzwndocno) enable validate;

create unique index gzwn_pk on gzwn_t (gzwndocno);

grant select on gzwn_t to tiptop;
grant update on gzwn_t to tiptop;
grant delete on gzwn_t to tiptop;
grant insert on gzwn_t to tiptop;

exit;
