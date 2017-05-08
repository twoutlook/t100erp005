/* 
================================================================================
檔案代號:gcao_t
檔案名稱:券資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table gcao_t
(
gcaoent       number(5)      ,/* 企業編號 */
gcao001       varchar2(30)      ,/* 券編號 */
gcao002       varchar2(10)      ,/* 券種編號 */
gcao003       varchar2(10)      ,/* 券面額編號 */
gcao004       number(20,6)      ,/* 券單位金額 */
gcao005       varchar2(1)      ,/* 券流轉狀態 */
gcao006       varchar2(1)      ,/* 券發出方式 */
gcao007       number(5,0)      ,/* 券遞延金額 */
gcao008       date      ,/* 生效日期 */
gcao009       date      ,/* 失效日期 */
gcao010       varchar2(40)      ,/* 可提貨商品編號 */
gcao011       varchar2(10)      ,/* 發行營運組織 */
gcao012       date      ,/* 發行日期 */
gcao013       varchar2(10)      ,/* 發行異動營運組織 */
gcao014       varchar2(10)      ,/* 發售營運組織 */
gcao015       date      ,/* 發售日期 */
gcao016       varchar2(10)      ,/* 發售異動營運組織 */
gcao017       varchar2(10)      ,/* 銷退營運組織 */
gcao018       date      ,/* 銷退日期 */
gcao019       varchar2(10)      ,/* 銷退異動營運組織 */
gcao020       varchar2(10)      ,/* 收券營運組織 */
gcao021       date      ,/* 收券日期 */
gcao022       varchar2(10)      ,/* 收券異動營運組織 */
gcao023       varchar2(10)      ,/* 核銷營運組織 */
gcao024       date      ,/* 核銷日期 */
gcao025       varchar2(10)      ,/* 核銷異動營運組織 */
gcao026       varchar2(10)      ,/* 停用營運組織 */
gcao027       date      ,/* 停用日期 */
gcao028       varchar2(10)      ,/* 停用異動營運組織 */
gcao029       varchar2(10)      ,/* 作廢營運組織 */
gcao030       date      ,/* 作廢日期 */
gcao031       varchar2(10)      ,/* 作廢異動營運組織 */
gcao032       number(20,6)      ,/* 售券實收金額 */
gcao033       number(20,6)      ,/* 折扣率 */
gcao034       varchar2(30)      ,/* 會員編號 */
gcao100       varchar2(40)      ,/* GUID */
gcao035       varchar2(1)      ,/* 失效券財務立帳否 */
gcao036       varchar2(10)      ,/* 校驗碼 */
gcao037       varchar2(10)      ,/* 稅別 */
gcao038       varchar2(10)      ,/* 售券組織 */
gcao039       varchar2(20)      ,/* 發行異動來源單號 */
gcao040       varchar2(20)      ,/* 發售異動來源單號 */
gcao041       varchar2(20)      ,/* 銷退異動來源單號 */
gcao042       varchar2(20)      ,/* 收券異動來源單號 */
gcao043       varchar2(20)      ,/* 核銷異動來源單號 */
gcao044       varchar2(20)      ,/* 停用異動來源單號 */
gcao045       varchar2(20)      /* 作廢異動來源單號 */
);
alter table gcao_t add constraint gcao_pk primary key (gcaoent,gcao001) enable validate;

create unique index gcao_pk on gcao_t (gcaoent,gcao001);

grant select on gcao_t to tiptop;
grant update on gcao_t to tiptop;
grant delete on gcao_t to tiptop;
grant insert on gcao_t to tiptop;

exit;
