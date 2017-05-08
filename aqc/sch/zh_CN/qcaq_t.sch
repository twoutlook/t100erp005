/* 
================================================================================
檔案代號:qcaq_t
檔案名稱:每月品質分數統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table qcaq_t
(
qcaqent       number(5)      ,/* 企業編號 */
qcaqsite       varchar2(10)      ,/* 營運據點 */
qcaq000       varchar2(10)      ,/* QC類型 */
qcaq001       number(5,0)      ,/* 年度 */
qcaq002       number(5,0)      ,/* 期別 */
qcaq003       varchar2(40)      ,/* 料件編號 */
qcaq004       varchar2(256)      ,/* 產品特徵 */
qcaq005       varchar2(10)      ,/* 交易對象 */
qcaq006       varchar2(10)      ,/* 部門 */
qcaq007       varchar2(10)      ,/* 作業編號 */
qcaq008       number(20,6)      ,/* 送驗量 */
qcaq009       number(20,6)      ,/* 抽驗量 */
qcaq010       number(20,6)      ,/* 不良數量 */
qcaq011       number(20,6)      ,/* 不良率 */
qcaq012       number(20,6)      ,/* 收貨批數 */
qcaq013       number(20,6)      ,/* 檢驗批數 */
qcaq014       number(20,6)      ,/* 合格批數 */
qcaq015       number(20,6)      ,/* 不合格批數 */
qcaq016       number(20,6)      ,/* 驗退批數 */
qcaq017       number(20,6)      ,/* 特採批數 */
qcaq018       number(20,6)      ,/* 批合格率 */
qcaq019       number(20,6)      ,/* 批不合格率 */
qcaq020       number(20,6)      ,/* 批驗退率 */
qcaq021       number(20,6)      /* 批特採率 */
);
alter table qcaq_t add constraint qcaq_pk primary key (qcaqent,qcaqsite,qcaq000,qcaq001,qcaq002,qcaq003,qcaq004,qcaq005,qcaq006,qcaq007) enable validate;

create unique index qcaq_pk on qcaq_t (qcaqent,qcaqsite,qcaq000,qcaq001,qcaq002,qcaq003,qcaq004,qcaq005,qcaq006,qcaq007);

grant select on qcaq_t to tiptop;
grant update on qcaq_t to tiptop;
grant delete on qcaq_t to tiptop;
grant insert on qcaq_t to tiptop;

exit;
