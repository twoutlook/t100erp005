/* 
================================================================================
檔案代號:pspj_t
檔案名稱:工單結果暫存檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspj_t
(
pspjent       number(5)      ,/* 企業編號 */
pspjsite       varchar2(10)      ,/* 營運據點 */
pspj001       varchar2(10)      ,/* APS版本 */
pspj002       varchar2(20)      ,/* 執行日期時間 */
pspj003       varchar2(40)      ,/* 工單編號 */
pspj004       number(20,6)      ,/* 需求數量 */
pspj005       varchar2(40)      ,/* EPR工單編號 */
pspj006       date      ,/* ERP預計完工日 */
pspj007       date      ,/* ERP預計開立日 */
pspj008       number(5,0)      ,/* 建議單據 */
pspj009       varchar2(500)      ,/* 品號 */
pspj010       date      ,/* 預計完工時間 */
pspj011       date      ,/* 預計發放時間 */
pspj012       varchar2(80)      ,/* 途程編號 */
pspj013       number(20,6)      ,/* 已生產量 */
pspj014       number(20,6)      ,/* 報廢數量 */
pspj015       number(5,0)      ,/* 狀態 */
pspj016       date      ,/* 物料限制時間 */
pspj017       number(5,0)      ,/* 使用工單製程 */
pspj018       number(5,0)      ,/* 自動轉外包工單 */
pspj019       number(5,0)      ,/* 自動外購取消 */
pspj020       varchar2(10)      /* 外包商編號 */
);
alter table pspj_t add constraint pspj_pk primary key (pspjent,pspjsite,pspj001,pspj002,pspj003) enable validate;

create unique index pspj_pk on pspj_t (pspjent,pspjsite,pspj001,pspj002,pspj003);

grant select on pspj_t to tiptop;
grant update on pspj_t to tiptop;
grant delete on pspj_t to tiptop;
grant insert on pspj_t to tiptop;

exit;
