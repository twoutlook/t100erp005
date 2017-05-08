/* 
================================================================================
檔案代號:debf_t
檔案名稱:門店單品銷售核銷供應商日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table debf_t
(
debfent       number(5)      ,/* 企業編號 */
debfsite       varchar2(10)      ,/* 營運據點 */
debf001       varchar2(10)      ,/* 層級類型 */
debf002       date      ,/* 統計日期 */
debf003       number(5,0)      ,/* 會計週 */
debf004       number(5,0)      ,/* 會計期 */
debf005       varchar2(10)      ,/* 庫區編號 */
debf006       varchar2(10)      ,/* 庫區類型 */
debf007       varchar2(10)      ,/* 存貨管理方式 */
debf008       varchar2(10)      ,/* 庫區業態 */
debf009       varchar2(40)      ,/* 商品編號 */
debf010       varchar2(40)      ,/* 商品條碼 */
debf011       varchar2(255)      ,/* 商品品名 */
debf012       varchar2(255)      ,/* 商品規格 */
debf013       varchar2(20)      ,/* 品牌 */
debf014       varchar2(10)      ,/* 供應商 */
debf015       varchar2(10)      ,/* 結算方式 */
debf016       varchar2(10)      ,/* 品類編號 */
debf017       varchar2(20)      ,/* 專櫃編號 */
debf018       varchar2(10)      ,/* 稅別編號 */
debf019       number(20,6)      ,/* 稅額 */
debf020       varchar2(10)      ,/* 銷售單位 */
debf021       number(20,6)      ,/* 銷售數量 */
debf022       number(20,6)      ,/* 銷售成本 */
debf023       number(20,6)      ,/* 進價金額 */
debf024       number(20,6)      ,/* 原價金額 */
debf025       number(20,6)      ,/* 未稅金額 */
debf026       number(20,6)      ,/* 應收金額 */
debf027       number(20,6)      ,/* 毛利 */
debf028       number(20,6)      ,/* 毛利率 */
debf030       number(20,6)      ,/* 促銷銷售數量 */
debf031       number(20,6)      ,/* 促銷應收金額 */
debf032       number(20,6)      ,/* 打折金額 */
debf033       number(20,6)      ,/* 變價金額 */
debf034       number(20,6)      ,/* 退貨金額 */
debf035       number(20,6)      ,/* 後臺銷售數量 */
debf036       number(20,6)      ,/* 後臺進價金額 */
debf037       number(20,6)      ,/* 後臺應收金額 */
debf038       number(20,6)      ,/* 前臺銷售數量 */
debf039       number(20,6)      ,/* 前臺進價金額 */
debf040       number(20,6)      ,/* 前臺應收金額 */
debf041       number(5,0)      ,/* 統計年度 */
debf042       number(5,0)      ,/* 統計月份 */
debf043       varchar2(256)      ,/* 產品特徵 */
debf045       number(20,6)      ,/* 抵扣券金額 */
debf046       number(20,6)      ,/* 會員折扣金額 */
debf047       number(20,6)      ,/* 實收金額 */
debf049       varchar2(10)      ,/* 經營方式 */
debf053       varchar2(10)      /* 管理品類編號 */
);
alter table debf_t add constraint debf_pk primary key (debfent,debfsite,debf002,debf009,debf014,debf020,debf043) enable validate;

create unique index debf_pk on debf_t (debfent,debfsite,debf002,debf009,debf014,debf020,debf043);

grant select on debf_t to tiptop;
grant update on debf_t to tiptop;
grant delete on debf_t to tiptop;
grant insert on debf_t to tiptop;

exit;
