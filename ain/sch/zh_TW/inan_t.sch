/* 
================================================================================
檔案代號:inan_t
檔案名稱:庫存在揀量統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table inan_t
(
inanent       number(5)      ,/* 企業編號 */
inansite       varchar2(10)      ,/* 營運據點 */
inan000       varchar2(1)      ,/* 庫存類型 */
inan001       varchar2(40)      ,/* 料件編號 */
inan002       varchar2(256)      ,/* 產品特徵 */
inan003       varchar2(30)      ,/* 庫存管理特徵 */
inan004       varchar2(10)      ,/* 庫位編號 */
inan005       varchar2(10)      ,/* 儲位編號 */
inan006       varchar2(30)      ,/* 批號 */
inan007       varchar2(10)      ,/* 庫存單位 */
inan010       number(20,6)      /* 在揀量 */
);
alter table inan_t add constraint inan_pk primary key (inanent,inansite,inan000,inan001,inan002,inan003,inan004,inan005,inan006,inan007) enable validate;

create unique index inan_pk on inan_t (inanent,inansite,inan000,inan001,inan002,inan003,inan004,inan005,inan006,inan007);

grant select on inan_t to tiptop;
grant update on inan_t to tiptop;
grant delete on inan_t to tiptop;
grant insert on inan_t to tiptop;

exit;
