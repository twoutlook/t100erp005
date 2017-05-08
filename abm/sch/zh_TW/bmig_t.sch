/* 
================================================================================
檔案代號:bmig_t
檔案名稱:料件承認異動記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table bmig_t
(
bmigent       number(5)      ,/* 企業代碼 */
bmig001       varchar2(40)      ,/* 承認料件編號 */
bmig002       varchar2(10)      ,/* 作業編號 */
bmig003       varchar2(10)      ,/* 作業序 */
bmig004       varchar2(40)      ,/* 承認主件料號 */
bmig005       varchar2(256)      ,/* 產品特徵 */
bmig006       varchar2(10)      ,/* 承認類型 */
bmig007       varchar2(10)      ,/* 廠商/客戶編號 */
bmig008       varchar2(40)      ,/* 交易對象料號 */
bmig009       varchar2(10)      ,/* 承認狀態 */
bmig010       timestamp(0)      ,/* 異動日期 */
bmig011       date      ,/* 承認日期 */
bmig012       varchar2(80)      ,/* 承認文號 */
bmig013       number(20,6)      ,/* 限制數量(暫時承認) */
bmig014       date      ,/* 失效日期(暫時承認) */
bmig015       varchar2(20)      ,/* 料件承認申請單號 */
bmig016       date      ,/* 承認有效開始日期 */
bmig017       date      ,/* 承認有效截止日期 */
bmig018       varchar2(20)      ,/* 資料修改者 */
bmig019       varchar2(10)      /* 資料修改部門 */
);
alter table bmig_t add constraint bmig_pk primary key (bmigent,bmig001,bmig002,bmig003,bmig004,bmig005,bmig006,bmig007,bmig009,bmig010) enable validate;

create unique index bmig_pk on bmig_t (bmigent,bmig001,bmig002,bmig003,bmig004,bmig005,bmig006,bmig007,bmig009,bmig010);

grant select on bmig_t to tiptop;
grant update on bmig_t to tiptop;
grant delete on bmig_t to tiptop;
grant insert on bmig_t to tiptop;

exit;
