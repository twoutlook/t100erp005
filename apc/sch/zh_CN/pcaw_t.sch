/* 
================================================================================
檔案代號:pcaw_t
檔案名稱:POS營業明細資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pcaw_t
(
pcawent       number(5)      ,/* 企業代碼 */
pcawsite       varchar2(10)      ,/* 營運據點 */
pcaw001       date      ,/* 營業日期 */
pcaw002       varchar2(10)      ,/* 機號 */
pcaw003       number(10,0)      ,/* 項次 */
pcaw004       varchar2(1)      ,/* 操作對象 */
pcaw005       varchar2(10)      ,/* 用戶編碼 */
pcaw006       date      ,/* 系統日期 */
pcaw007       varchar2(8)      ,/* 系統時間 */
pcaw008       number(20,6)      ,/* 銷售單頭數量 */
pcaw009       number(20,6)      ,/* 銷售單身數量 */
pcaw010       number(20,6)      ,/* 髮卡單頭數量 */
pcaw011       number(20,6)      ,/* 髮卡單身數量 */
pcaw012       number(20,6)      ,/* 充值單頭數量 */
pcaw013       number(20,6)      ,/* 售券單頭數量 */
pcaw014       number(20,6)      ,/* 售券單身數量 */
pcaw015       number(20,6)      ,/* 換卡單頭數量 */
pcaw016       number(20,6)      ,/* 發票數量 */
pcaw017       varchar2(1)      ,/* 離線數據 */
pcaw018       number(20,6)      ,/* 銷售折扣筆數 */
pcaw019       number(20,6)      ,/* 銷售收款筆數 */
pcaw020       number(20,6)      ,/* 銷售收款明細筆數 */
pcaw021       number(20,6)      ,/* 銷售折價券筆數 */
pcaw022       number(20,6)      ,/* 銷售換贈筆數 */
pcaw023       number(20,6)      ,/* 髮卡收款筆數 */
pcaw024       number(20,6)      ,/* 髮卡折扣筆數 */
pcaw025       number(20,6)      ,/* 充值收款筆數 */
pcaw026       number(20,6)      ,/* 充值折扣筆數 */
pcaw027       number(20,6)      ,/* 換卡收款筆數 */
pcaw028       number(20,6)      ,/* 售券收款筆數 */
pcaw029       number(20,6)      ,/* 售券折扣筆數 */
pcaw030       varchar2(1)      ,/* 資料檢核完整否 */
pcaw031       varchar2(10)      ,/* 班別編號 */
pcawmoddt       timestamp(0)      ,/* 最近修改日 */
pcawstus       varchar2(10)      /* 狀態碼 */
);
alter table pcaw_t add constraint pcaw_pk primary key (pcawent,pcawsite,pcaw001,pcaw002,pcaw003,pcaw005) enable validate;

create unique index pcaw_pk on pcaw_t (pcawent,pcawsite,pcaw001,pcaw002,pcaw003,pcaw005);

grant select on pcaw_t to tiptop;
grant update on pcaw_t to tiptop;
grant delete on pcaw_t to tiptop;
grant insert on pcaw_t to tiptop;

exit;
