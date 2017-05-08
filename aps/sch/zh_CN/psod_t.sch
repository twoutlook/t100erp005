/* 
================================================================================
檔案代號:psod_t
檔案名稱:MPS訂單中介檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psod_t
(
psodent       number(5)      ,/* 企業編號 */
psodsite       varchar2(10)      ,/* 營運據點 */
psod001       varchar2(10)      ,/* APS版本 */
psod002       varchar2(20)      ,/* 執行日期時間 */
psod003       varchar2(40)      ,/* 訂單編號 */
psod004       varchar2(500)      ,/* 品號 */
psod005       number(20,6)      ,/* 訂購數量 */
psod006       date      ,/* 交期 */
psod007       varchar2(10)      ,/* 客戶編號 */
psod008       number(5,0)      ,/* 納入排程 */
psod009       varchar2(10)      ,/* 訂單型式 */
psod010       number(10,0)      ,/* 優先順序 */
psod011       varchar2(40)      ,/* 銷售訂單編號 */
psod012       varchar2(40)      ,/* 客戶單號 */
psod013       number(20,6)      ,/* 已出貨量 */
psod014       date      ,/* 訂單開立日期 */
psod015       number(5,0)      ,/* 嚴守交期 */
psod016       varchar2(10)      ,/* 單位 */
psod017       date      ,/* 真實交期 */
psod018       varchar2(40)      ,/* 品號 */
psod019       varchar2(256)      ,/* 品號特徵碼 */
psod020       number(20,6)      ,/* 贈備品量 */
psod021       number(20,6)      ,/* 業務數量 */
psod022       varchar2(10)      /* 業務單位 */
);
alter table psod_t add constraint psod_pk primary key (psodent,psodsite,psod001,psod002,psod003) enable validate;

create unique index psod_pk on psod_t (psodent,psodsite,psod001,psod002,psod003);

grant select on psod_t to tiptop;
grant update on psod_t to tiptop;
grant delete on psod_t to tiptop;
grant insert on psod_t to tiptop;

exit;
