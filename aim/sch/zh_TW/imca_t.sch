/* 
================================================================================
檔案代號:imca_t
檔案名稱:料件主分群檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imca_t
(
imcaent       number(5)      ,/* 企業編號 */
imcaownid       varchar2(20)      ,/* 資料所有者 */
imcaowndp       varchar2(10)      ,/* 資料所屬部門 */
imcacrtid       varchar2(20)      ,/* 資料建立者 */
imcacrtdt       timestamp(0)      ,/* 資料創建日 */
imcacrtdp       varchar2(10)      ,/* 資料建立部門 */
imcamodid       varchar2(20)      ,/* 資料修改者 */
imcamoddt       timestamp(0)      ,/* 最近修改日 */
imcastus       varchar2(10)      ,/* 狀態碼 */
imca001       varchar2(10)      ,/* 主分群碼 */
imca003       number(5,0)      ,/* 低階碼 */
imca004       varchar2(10)      ,/* 料件類別 */
imca005       varchar2(40)      ,/* 特徵組別 */
imca006       varchar2(10)      ,/* 基礎單位 */
imca010       varchar2(10)      ,/* 生命週期狀態 */
imca011       varchar2(10)      ,/* 產出類型 */
imca012       varchar2(1)      ,/* 允許副產品產出 */
imca013       varchar2(40)      ,/* 目錄編號 */
imca014       varchar2(40)      ,/* 產品條碼編號 */
imca018       varchar2(10)      ,/* 重量單位 */
imca022       varchar2(10)      ,/* 長度單位 */
imca024       varchar2(10)      ,/* 面積單位 */
imca026       varchar2(10)      ,/* 體積單位 */
imca027       varchar2(1)      ,/* 為包裝容器 */
imca029       varchar2(10)      ,/* 容量單位 */
imca030       number(20,6)      ,/* 超量容差(%) */
imca032       varchar2(10)      ,/* 載重單位 */
imca033       number(20,6)      ,/* 超重容差(%) */
imca036       varchar2(1)      ,/* 記錄組裝位置(插件) */
imca037       varchar2(1)      ,/* 組裝位置須勾稽 */
imca038       varchar2(1)      ,/* 工程料件 */
imca041       varchar2(255)      ,/* 工程圖號 */
imca042       varchar2(20)      ,/* 主要模具編號 */
imca043       varchar2(10)      ,/* 據點研發可調整元件 */
imca044       varchar2(10)      ,/* AVL控管點 */
imca045       varchar2(10)      ,/* 生產國家地區 */
imca122       varchar2(10)      ,/* 產地分類 */
imca123       varchar2(80)      ,/* 產地說明 */
imca124       varchar2(10)      ,/* 進銷項稅目 */
imca126       varchar2(10)      ,/* 品牌 */
imca127       varchar2(10)      ,/* 系列 */
imca128       varchar2(10)      ,/* 型別 */
imca129       varchar2(10)      ,/* 功能 */
imca130       varchar2(80)      ,/* 成份 */
imca131       varchar2(10)      ,/* 價格帶 */
imca132       varchar2(10)      ,/* 其他屬性一 */
imca133       varchar2(10)      ,/* 其他屬性二 */
imca134       varchar2(10)      ,/* 其他屬性三 */
imca135       varchar2(10)      ,/* 其他屬性四 */
imca136       varchar2(10)      ,/* 其他屬性五 */
imca137       varchar2(10)      ,/* 其他屬性六 */
imca138       varchar2(10)      ,/* 其他屬性七 */
imca139       varchar2(10)      ,/* 其他屬性八 */
imca140       varchar2(10)      ,/* 其他屬性九 */
imca141       varchar2(10)      ,/* 其他屬性十 */
imca201       varchar2(10)      ,/* 庫存分群 */
imca202       varchar2(10)      ,/* 銷售分群 */
imca203       varchar2(10)      ,/* 採購分群 */
imca204       varchar2(10)      ,/* 生管分群 */
imca205       varchar2(10)      ,/* 品管分群 */
imca206       varchar2(10)      ,/* 財務分群 */
imca207       varchar2(10)      ,/* WMS分群 */
imca208       varchar2(10)      ,/* 關務分群 */
imca154       number(5,0)      ,/* 年份 */
imca155       varchar2(10)      ,/* 訂貨季 */
imca156       varchar2(10)      ,/* 性別 */
imca100       varchar2(10)      ,/* 條碼分類 */
imca109       varchar2(10)      ,/* 條碼類型 */
imca110       varchar2(1)      ,/* 季節性商品 */
imca111       date      ,/* 開始日期 */
imca112       date      ,/* 結束日期 */
imca121       varchar2(1)      /* 網絡經營 */
);
alter table imca_t add constraint imca_pk primary key (imcaent,imca001) enable validate;

create unique index imca_pk on imca_t (imcaent,imca001);

grant select on imca_t to tiptop;
grant update on imca_t to tiptop;
grant delete on imca_t to tiptop;
grant insert on imca_t to tiptop;

exit;
