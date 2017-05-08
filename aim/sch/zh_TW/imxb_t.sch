/* 
================================================================================
檔案代號:imxb_t
檔案名稱:imxb_t test
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imxb_t
(
imxbent       number(5)      ,/* 企業編號 */
imxb001       varchar2(40)      ,/* 料號 */
imxb002       varchar2(10)      ,/* 目前版本 */
imxb003       varchar2(10)      ,/* 主分群碼 */
imxb004       varchar2(10)      ,/* 料件類別 */
imxb005       varchar2(10)      ,/* 特徵組別 */
imxb006       varchar2(10)      ,/* 基礎單位 */
imxb009       varchar2(10)      ,/* 產品分類碼 */
imxb010       varchar2(10)      ,/* 生命週期狀態 */
imxb011       varchar2(10)      ,/* 產出類型 */
imxb012       varchar2(1)      ,/* 允許副產品產出 */
imxb013       varchar2(40)      ,/* 目錄編號 */
imxb014       varchar2(40)      ,/* 產品條碼編號 */
imxb015       varchar2(20)      ,/* 國際編號 */
imxb016       number(20,6)      ,/* 毛重 */
imxb017       number(20,6)      ,/* 淨重 */
imxb018       varchar2(10)      ,/* 重量單位 */
imxb019       number(20,6)      ,/* 長度 */
imxb020       number(20,6)      ,/* 寬度 */
imxb021       number(20,6)      ,/* 高度 */
imxb022       varchar2(10)      ,/* 長度單位 */
imxb023       number(20,6)      ,/* 面積 */
imxb024       varchar2(10)      ,/* 面積單位 */
imxb025       number(20,6)      ,/* 體積 */
imxb026       varchar2(10)      ,/* 體積單位 */
imxb027       varchar2(1)      ,/* 為包裝容器 */
imxb028       number(20,6)      ,/* 容量 */
imxb029       varchar2(10)      ,/* 容量單位 */
imxb030       number(20,6)      ,/* 超量容差(%) */
imxb031       number(20,6)      ,/* 載重量 */
imxb032       varchar2(10)      ,/* 載重單位 */
imxb033       number(20,6)      ,/* 超重容差(%) */
imxb034       varchar2(10)      ,/* 料號來源 */
imxb035       varchar2(40)      ,/* 來源參考料號 */
imxb036       varchar2(1)      ,/* 紀錄組裝位置(插件) */
imxb037       varchar2(1)      ,/* 組裝位置須勾稽 */
imxb038       varchar2(1)      ,/* 工程料件 */
imxb039       varchar2(40)      ,/* 轉正式料號 */
imxb040       date      ,/* 轉正式料號時間 */
imxb041       varchar2(255)      ,/* 工程圖號 */
imxb042       varchar2(20)      ,/* 主要模具編號 */
imxb043       varchar2(10)      ,/* 主要材質 */
imxb044       varchar2(10)      ,/* AVL控管點 */
imxb045       varchar2(10)      ,/* 生產國家地區 */
imxb100       varchar2(10)      ,/* 條碼類型 */
imxb101       varchar2(10)      ,/* 主供應商 */
imxb102       number(5,0)      ,/* 保質期(月) */
imxb103       number(5,0)      ,/* 保質期(天) */
imxb104       varchar2(10)      ,/* 庫存單位 */
imxb105       varchar2(10)      ,/* 銷售單位 */
imxb106       varchar2(10)      ,/* 銷售計價單位 */
imxb107       varchar2(10)      ,/* 採購單位 */
imxb108       varchar2(10)      ,/* 商品種類 */
imxb109       varchar2(10)      ,/* 商品性質 */
imxb110       varchar2(1)      ,/* 季節性商品 */
imxb111       date      ,/* 開始日期 */
imxb112       date      ,/* 結束日期 */
imxb113       number(5,0)      ,/* 價格因子 */
imxb114       varchar2(10)      ,/* 計價幣別 */
imxb115       number(20,6)      ,/* 預計進貨價格 */
imxb116       number(20,6)      ,/* 預計銷貨價格 */
imxb117       number(20,6)      ,/* 進銷差率 */
imxb118       number(15,3)      ,/* 試銷期(天) */
imxb119       number(20,6)      ,/* 試銷金額 */
imxb120       number(15,3)      ,/* 試銷數量 */
imxb121       varchar2(1)      ,/* 是否網路經營 */
imxb122       varchar2(10)      ,/* 產地分類 */
imxb123       varchar2(80)      ,/* 產地說明 */
imxb124       varchar2(10)      ,/* 進銷項稅目 */
imxb125       varchar2(10)      ,/* 一次性商品 */
imxb126       varchar2(10)      ,/* 品牌 */
imxb127       varchar2(10)      ,/* 系列 */
imxb128       varchar2(10)      ,/* 型別 */
imxb129       varchar2(10)      ,/* 功能 */
imxb130       varchar2(80)      ,/* 成份 */
imxb131       varchar2(10)      ,/* 價格帶 */
imxb132       varchar2(10)      ,/* 其它屬性一 */
imxb133       varchar2(10)      ,/* 其它屬性二 */
imxb134       varchar2(10)      ,/* 其它屬性三 */
imxb135       varchar2(10)      ,/* 其它屬性四 */
imxb136       varchar2(10)      ,/* 其它屬性五 */
imxb137       varchar2(10)      ,/* 其它屬性六 */
imxb138       varchar2(10)      ,/* 其它屬性七 */
imxb139       varchar2(10)      ,/* 其它屬性八 */
imxb140       varchar2(10)      ,/* 其它屬性九 */
imxb141       varchar2(10)      ,/* 其它屬性十 */
imxb142       varchar2(10)      ,/* 制定組織 */
imxbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imxbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imxbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imxbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imxbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imxbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imxbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imxbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imxbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imxbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imxbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imxbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imxbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imxbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imxbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imxbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imxbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imxbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imxbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imxbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imxbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imxbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imxbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imxbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imxbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imxbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imxbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imxbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imxbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imxbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imxb_t add constraint imxb_pk primary key (imxbent,imxb001) enable validate;

create unique index imxb_pk on imxb_t (imxbent,imxb001);

grant select on imxb_t to tiptop;
grant update on imxb_t to tiptop;
grant delete on imxb_t to tiptop;
grant insert on imxb_t to tiptop;

exit;
