/* 
================================================================================
檔案代號:pspk_t
檔案名稱:採購單結果暫存檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspk_t
(
pspkent       number(5)      ,/* 企業編號 */
pspksite       varchar2(10)      ,/* 營運據點 */
pspk001       varchar2(10)      ,/* APS版本 */
pspk002       varchar2(20)      ,/* 執行日期時間 */
pspk003       date      ,/* ERP預計到廠日 */
pspk004       varchar2(10)      ,/* 供應商位置 */
pspk005       varchar2(500)      ,/* 品號 */
pspk006       varchar2(40)      ,/* 採購單編號 */
pspk007       number(20,6)      ,/* 預計採購數量 */
pspk008       date      ,/* ERP預計開立日 */
pspk009       varchar2(10)      ,/* 供應商編號 */
pspk010       varchar2(40)      ,/* EPR工單編號 */
pspk011       number(20,6)      ,/* 已入庫數量 */
pspk012       number(5,0)      ,/* 狀態 */
pspk013       number(20,6)      ,/* 待驗量 */
pspk014       number(20,6)      ,/* 待入庫量 */
pspk015       number(20,6)      ,/* 驗退量 */
pspk016       date      ,/* 預計到廠日期 */
pspk017       date      ,/* 預計發放時間 */
pspk018       number(5,0)      ,/* 建議單據 */
pspk019       number(5,0)      ,/* 製造轉採購單 */
pspk020       varchar2(40)      ,/* 自動轉外購前的工單單號 */
pspk021       number(5,0)      ,/* 自動外購取消 */
pspk022       date      ,/* ERP預計到庫日 */
pspk023       date      ,/* 預計到庫日期 */
pspk024       number(20,6)      /* 可供給量 */
);
alter table pspk_t add constraint pspk_pk primary key (pspkent,pspksite,pspk001,pspk002,pspk006) enable validate;

create unique index pspk_pk on pspk_t (pspkent,pspksite,pspk001,pspk002,pspk006);

grant select on pspk_t to tiptop;
grant update on pspk_t to tiptop;
grant delete on pspk_t to tiptop;
grant insert on pspk_t to tiptop;

exit;
