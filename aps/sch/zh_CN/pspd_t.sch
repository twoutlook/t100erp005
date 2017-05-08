/* 
================================================================================
檔案代號:pspd_t
檔案名稱:需求結果檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspd_t
(
pspdent       number(5)      ,/* 企業編號 */
pspdsite       varchar2(10)      ,/* 營運據點 */
pspd001       varchar2(10)      ,/* APS版本 */
pspd002       varchar2(20)      ,/* 執行日期時間 */
pspd003       varchar2(40)      ,/* 需求來源編號 */
pspd004       number(5,0)      ,/* 需求來源型態 */
pspd005       number(10,0)      ,/* 需求序 */
pspd006       number(10,0)      ,/* 分配序 */
pspd007       number(10,0)      ,/* 替代序 */
pspd008       varchar2(40)      ,/* 訂單編號 */
pspd009       varchar2(500)      ,/* 品號 */
pspd010       number(5,0)      ,/* 取替代型態 */
pspd011       date      ,/* 需求日 */
pspd012       number(20,6)      ,/* 需求數量 */
pspd013       number(20,6)      ,/* 預測耗用量 */
pspd014       number(20,6)      ,/* 預計短缺量 */
pspd015       varchar2(500)      ,/* 原始需求品號 */
pspd016       number(20,6)      ,/* 主料需求數量 */
pspd017       varchar2(500)      ,/* 上階需求料號 */
pspd018       number(20,6)      ,/* 已領用量 */
pspd019       number(20,6)      ,/* 虛擬訂單實際需求量 */
pspd020       varchar2(40)      ,/* 品號 */
pspd021       varchar2(256)      ,/* 品號特徵碼 */
pspd022       varchar2(40)      ,/* 需求(主料)品號 */
pspd023       varchar2(256)      ,/* 需求品號特徵碼 */
pspd024       varchar2(40)      ,/* 工單品號 */
pspd025       varchar2(256)      ,/* 工單特徵碼 */
pspd026       varchar2(80)      ,/* BOM序號 */
pspd027       number(10,0)      /* 領料序 */
);


grant select on pspd_t to tiptop;
grant update on pspd_t to tiptop;
grant delete on pspd_t to tiptop;
grant insert on pspd_t to tiptop;

exit;
