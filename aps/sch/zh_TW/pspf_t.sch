/* 
================================================================================
檔案代號:pspf_t
檔案名稱:供給結果檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspf_t
(
pspfent       number(5)      ,/* 企業編號 */
pspfsite       varchar2(10)      ,/* 營運據點 */
pspf001       varchar2(10)      ,/* APS版本 */
pspf002       varchar2(20)      ,/* 執行日期時間 */
pspf003       varchar2(40)      ,/* 需求來源編號 */
pspf004       number(5,0)      ,/* 需求來源型態 */
pspf005       number(10,0)      ,/* 需求序 */
pspf006       number(10,0)      ,/* 分配序 */
pspf007       number(10,0)      ,/* 替代序 */
pspf008       number(10,0)      ,/* 供給序 */
pspf009       varchar2(10)      ,/* 供給型態 */
pspf010       varchar2(40)      ,/* 供給單號 */
pspf011       varchar2(10)      ,/* 供給庫別 */
pspf012       varchar2(10)      ,/* 供給庫位 */
pspf013       number(20,6)      ,/* 可供給數量 */
pspf014       date      ,/* 供給時間 */
pspf015       number(20,6)      ,/* 原供給量 */
pspf016       number(10,0)      ,/* 唯一碼 */
pspf017       number(10,0)      ,/* 上階唯一碼 */
pspf018       number(20,6)      ,/* 採購在驗數量 */
pspf019       number(5,0)      ,/* 聯副產品 */
pspf020       number(10,0)      /* 唯一碼 */
);
alter table pspf_t add constraint pspf_pk primary key (pspfent,pspfsite,pspf001,pspf002,pspf003,pspf004,pspf005,pspf006,pspf007,pspf008) enable validate;

create unique index pspf_pk on pspf_t (pspfent,pspfsite,pspf001,pspf002,pspf003,pspf004,pspf005,pspf006,pspf007,pspf008);

grant select on pspf_t to tiptop;
grant update on pspf_t to tiptop;
grant delete on pspf_t to tiptop;
grant insert on pspf_t to tiptop;

exit;
