/* 
================================================================================
檔案代號:fabt_t
檔案名稱:固定資產盤點標籤檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabt_t
(
fabtent       number(5)      ,/* 企業編號 */
fabtcomp       varchar2(10)      ,/* 法人 */
fabt000       varchar2(10)      ,/* 資產中心 */
fabt001       varchar2(20)      ,/* 帳務人員 */
fabt002       varchar2(10)      ,/* 盤點編號 */
fabt003       number(10,0)      ,/* 盤點序號 */
fabt004       number(10,0)      ,/* 項次 */
fabt005       varchar2(10)      ,/* 標籤條碼 */
fabt006       varchar2(10)      ,/* s/n號 */
fabt007       varchar2(10)      ,/* 單位 */
fabt008       number(20,6)      ,/* 數量 */
fabt009       number(20,6)      ,/* 在外數量 */
fabt010       varchar2(10)      ,/* 保管部門 */
fabt011       varchar2(20)      ,/* 保管人員 */
fabt012       varchar2(10)      ,/* 存放位置 */
fabt013       varchar2(20)      ,/* 負責人員 */
fabt014       varchar2(10)      ,/* 管理組織 */
fabt015       varchar2(10)      ,/* 所有組織 */
fabt016       varchar2(10)      ,/* 核算組織 */
fabt017       varchar2(10)      ,/* 歸屬法人 */
fabt020       varchar2(10)      ,/* 單位 */
fabt021       number(20,6)      ,/* 數量 */
fabt022       varchar2(10)      ,/* 實際保管部門 */
fabt023       varchar2(20)      ,/* 實際保管人員 */
fabt024       varchar2(10)      ,/* 實際存放位置 */
fabt025       varchar2(10)      ,/* 實際管理組織 */
fabt026       varchar2(10)      ,/* 實際所有組織 */
fabt027       varchar2(10)      ,/* 實際核算組織 */
fabt028       varchar2(10)      ,/* 實際歸屬法人 */
fabt029       date      ,/* 盤點日期 */
fabt030       varchar2(20)      ,/* 盤點人員 */
fabt031       date      ,/* 產生日期 */
fabt032       varchar2(20)      ,/* 產生人員 */
fabt033       varchar2(1)      ,/* 過帳碼 */
fabt034       varchar2(20)      /* 實際負責人員 */
);
alter table fabt_t add constraint fabt_pk primary key (fabtent,fabt002,fabt003,fabt004) enable validate;

create unique index fabt_pk on fabt_t (fabtent,fabt002,fabt003,fabt004);

grant select on fabt_t to tiptop;
grant update on fabt_t to tiptop;
grant delete on fabt_t to tiptop;
grant insert on fabt_t to tiptop;

exit;
