/* 
================================================================================
檔案代號:xcfh_t
檔案名稱:LCM存貨成本和市價計算明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcfh_t
(
xcfhent       number(5)      ,/* 企業編號 */
xcfhcomp       varchar2(10)      ,/* 法人組織 */
xcfhld       varchar2(5)      ,/* 帳套 */
xcfh001       varchar2(1)      ,/* 帳套本位幣順序 */
xcfh002       varchar2(30)      ,/* 成本域 */
xcfh003       varchar2(10)      ,/* 成本計算類型 */
xcfh004       number(5,0)      ,/* 年度 */
xcfh005       number(5,0)      ,/* 期別 */
xcfh006       varchar2(40)      ,/* 料件 */
xcfh007       varchar2(256)      ,/* 特性 */
xcfh008       varchar2(30)      ,/* 批號 */
xcfh009       varchar2(1)      ,/* 取價類別 */
xcfhseq       number(10,0)      ,/* 項次 */
xcfh010       varchar2(20)      ,/* 單據編號 */
xcfh011       number(10,0)      ,/* 項次 */
xcfh012       varchar2(10)      ,/* 組織編號 */
xcfh013       date      ,/* 單據日期 */
xcfh014       varchar2(10)      ,/* 交易單位 */
xcfh015       varchar2(10)      ,/* 成本單位 */
xcfh016       number(20,6)      ,/* 單位轉換率 */
xcfh017       varchar2(10)      ,/* 幣別 */
xcfh018       number(20,6)      ,/* 數量 */
xcfh019       number(20,6)      ,/* 交易單價 */
xcfh020       number(20,6)      ,/* 金額 */
xcfh021       varchar2(10)      ,/* 庫存異動類別 */
xcfh022       date      ,/* 計算起始日期 */
xcfh023       date      /* 計算截至日期 */
);
alter table xcfh_t add constraint xcfh_pk primary key (xcfhent,xcfhld,xcfh001,xcfh002,xcfh003,xcfh004,xcfh005,xcfh006,xcfh007,xcfh008,xcfh009,xcfhseq) enable validate;

create unique index xcfh_pk on xcfh_t (xcfhent,xcfhld,xcfh001,xcfh002,xcfh003,xcfh004,xcfh005,xcfh006,xcfh007,xcfh008,xcfh009,xcfhseq);

grant select on xcfh_t to tiptop;
grant update on xcfh_t to tiptop;
grant delete on xcfh_t to tiptop;
grant insert on xcfh_t to tiptop;

exit;
