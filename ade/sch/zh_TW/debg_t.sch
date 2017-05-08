/* 
================================================================================
檔案代號:debg_t
檔案名稱:門店專櫃日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debg_t
(
debgent       number(5)      ,/* 企業編號 */
debgsite       varchar2(10)      ,/* 營運據點 */
debg001       varchar2(10)      ,/* 層級類型 */
debg002       date      ,/* 統計日期 */
debg003       number(5,0)      ,/* 會計週 */
debg004       number(5,0)      ,/* 會計期 */
debg005       varchar2(20)      ,/* 專櫃編號 */
debg006       varchar2(10)      ,/* 專櫃類型 */
debg007       varchar2(10)      ,/* 品類編號 */
debg008       varchar2(10)      ,/* 稅別編號 */
debg009       number(20,6)      ,/* 稅額 */
debg010       number(20,6)      ,/* 銷售數量 */
debg011       number(20,6)      ,/* 銷售成本 */
debg012       number(20,6)      ,/* 進價金額 */
debg013       number(20,6)      ,/* 原價金額 */
debg014       number(20,6)      ,/* 未稅金額 */
debg015       number(20,6)      ,/* 應收金額 */
debg016       number(20,6)      ,/* 折扣金額 */
debg017       number(20,6)      ,/* 實收金額 */
debg018       number(20,6)      ,/* 毛利 */
debg019       number(20,6)      ,/* 毛利率 */
debg020       number(20,6)      ,/* 客單數 */
debg021       number(20,6)      ,/* 退貨金額 */
debg022       number(20,6)      ,/* 退貨單據數 */
debg023       number(20,6)      ,/* 打折金額 */
debg024       number(20,6)      ,/* 變價金額 */
debg025       number(20,6)      ,/* 抵扣券金額 */
debg026       number(20,6)      ,/* 會員折扣金額 */
debg027       varchar2(10)      ,/* 經營方式 */
debg028       varchar2(10)      ,/* 鋪位版本 */
debg029       varchar2(10)      ,/* 鋪位狀態 */
debg030       varchar2(255)      ,/* 門牌號 */
debg031       varchar2(10)      ,/* 品牌 */
debg032       number(20,6)      ,/* 建築面積 */
debg033       number(20,6)      ,/* 測量面積 */
debg034       number(20,6)      ,/* 經營面積 */
debg035       varchar2(10)      ,/* 樓棟 */
debg036       varchar2(10)      ,/* 樓層 */
debg037       varchar2(10)      ,/* 區域 */
debg038       varchar2(20)      ,/* 合約編號 */
debg039       varchar2(10)      ,/* 合約版本 */
debg040       varchar2(10)      ,/* 合約狀態 */
debg041       date      ,/* 租賃開始日 */
debg042       date      ,/* 租賃結束日 */
debg043       date      ,/* 合約到期日 */
debg044       varchar2(10)      /* 商戶編號 */
);
alter table debg_t add constraint debg_pk primary key (debgent,debgsite,debg002,debg005,debg007,debg008) enable validate;

create  index debg_n01 on debg_t (debgent,debg002);
create unique index debg_pk on debg_t (debgent,debgsite,debg002,debg005,debg007,debg008);

grant select on debg_t to tiptop;
grant update on debg_t to tiptop;
grant delete on debg_t to tiptop;
grant insert on debg_t to tiptop;

exit;
