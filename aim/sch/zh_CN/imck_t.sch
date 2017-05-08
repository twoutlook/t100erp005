/* 
================================================================================
檔案代號:imck_t
檔案名稱:流通商品主分群碼檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imck_t
(
imckent       number(5)      ,/* 企業編號 */
imckunit       varchar2(10)      ,/* 應用組織 */
imck001       varchar2(10)      ,/* 主分群碼 */
imck006       varchar2(10)      ,/* 基礎單位 */
imck009       varchar2(10)      ,/* 產品分類碼 */
imck010       varchar2(10)      ,/* 生命週期狀態 */
imck048       varchar2(10)      ,/* 進銷項稅目 */
imck100       varchar2(10)      ,/* 條碼分類 */
imck101       varchar2(10)      ,/* 主供應商 */
imck102       number(5,0)      ,/* 保質期(月) */
imck103       number(5,0)      ,/* 保質期(天) */
imck104       varchar2(10)      ,/* 庫存單位 */
imck105       varchar2(10)      ,/* 銷售單位 */
imck106       varchar2(10)      ,/* 銷售計價單位 */
imck107       varchar2(10)      ,/* 採購單位 */
imck108       varchar2(10)      ,/* 商品種類 */
imck109       varchar2(10)      ,/* 條碼類型 */
imck110       varchar2(1)      ,/* 季節性商品 */
imck111       date      ,/* 開始日期 */
imck112       date      ,/* 結束日期 */
imck113       number(5,0)      ,/* 價格因子 */
imck114       varchar2(10)      ,/* 計價幣別 */
imck115       number(20,6)      ,/* 預計進貨價格 */
imck116       number(20,6)      ,/* 預計銷貨價格 */
imck117       number(20,6)      ,/* 進銷差率 */
imck118       number(5,0)      ,/* 試銷期(天) */
imck119       number(20,6)      ,/* 試銷金額 */
imck120       number(20,6)      ,/* 試銷數量 */
imck121       varchar2(1)      ,/* 是否網路經營 */
imck122       varchar2(10)      ,/* 產地分類 */
imck123       varchar2(80)      ,/* 產地說明 */
imck124       varchar2(10)      ,/* 進銷項稅別 */
imck125       varchar2(1)      ,/* 一次性商品 */
imck126       varchar2(10)      ,/* 品牌 */
imck127       varchar2(10)      ,/* 系列 */
imck128       varchar2(10)      ,/* 型別 */
imck129       varchar2(10)      ,/* 功能 */
imck130       varchar2(80)      ,/* 成份 */
imck131       varchar2(10)      ,/* 價格帶 */
imck132       varchar2(10)      ,/* 其它屬性一 */
imck133       varchar2(10)      ,/* 其它屬性二 */
imck134       varchar2(10)      ,/* 其它屬性三 */
imck135       varchar2(10)      ,/* 其它屬性四 */
imck136       varchar2(10)      ,/* 其它屬性五 */
imck137       varchar2(10)      ,/* 其它屬性六 */
imck138       varchar2(10)      ,/* 其它屬性七 */
imck139       varchar2(10)      ,/* 其它屬性八 */
imck140       varchar2(10)      ,/* 其它屬性九 */
imck141       varchar2(10)      ,/* 其它屬性十 */
imck142       varchar2(10)      ,/* no use */
imck143       varchar2(10)      ,/* 產品組編號 */
imck144       varchar2(1)      ,/* 庫存多單位 */
imck145       varchar2(10)      ,/* 採購計價單位 */
imck146       varchar2(10)      ,/* 成本單位 */
imckstus       varchar2(10)      ,/* 狀態碼 */
imckownid       varchar2(20)      ,/* 資料所有者 */
imckowndp       varchar2(10)      ,/* 資料所屬部門 */
imckcrtid       varchar2(20)      ,/* 資料建立者 */
imckcrtdp       varchar2(10)      ,/* 資料建立部門 */
imckcrtdt       timestamp(0)      ,/* 資料創建日 */
imckmodid       varchar2(20)      ,/* 資料修改者 */
imckmoddt       timestamp(0)      ,/* 最近修改日 */
imck004       varchar2(10)      /* 商品類別 */
);
alter table imck_t add constraint imck_pk primary key (imckent,imck001) enable validate;

create unique index imck_pk on imck_t (imckent,imck001);

grant select on imck_t to tiptop;
grant update on imck_t to tiptop;
grant delete on imck_t to tiptop;
grant insert on imck_t to tiptop;

exit;
