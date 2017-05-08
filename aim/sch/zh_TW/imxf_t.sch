/* 
================================================================================
檔案代號:imxf_t
檔案名稱:cch_test
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imxf_t
(
imxfent       number(5)      ,/* 企業編號 */
imxf001       varchar2(40)      ,/* 料號 */
imxf002       varchar2(10)      ,/* 目前版本 */
imxf003       varchar2(10)      ,/* 主分群碼 */
imxf004       varchar2(10)      ,/* 料件類別 */
imxf005       varchar2(10)      ,/* 特徵組別 */
imxf006       varchar2(10)      ,/* 基礎單位 */
imxf009       varchar2(10)      ,/* 產品分類碼 */
imxf010       varchar2(10)      ,/* 生命週期狀態 */
imxf011       varchar2(10)      ,/* 產出類型 */
imxf012       varchar2(1)      ,/* 允許副產品產出 */
imxf013       varchar2(40)      ,/* 目錄編號 */
imxf014       varchar2(40)      ,/* 產品條碼編號 */
imxf015       varchar2(20)      ,/* 國際編號 */
imxf016       number(20,6)      ,/* 毛重 */
imxf017       number(20,6)      ,/* 淨重 */
imxf018       varchar2(10)      ,/* 重量單位 */
imxf019       number(20,6)      ,/* 長度 */
imxf020       number(20,6)      ,/* 寬度 */
imxf021       number(20,6)      ,/* 高度 */
imxf022       varchar2(10)      ,/* 長度單位 */
imxf023       number(20,6)      ,/* 面積 */
imxf024       varchar2(10)      ,/* 面積單位 */
imxf025       number(20,6)      ,/* 體積 */
imxf026       varchar2(10)      ,/* 體積單位 */
imxf027       varchar2(1)      ,/* 為包裝容器 */
imxf028       number(20,6)      ,/* 容量 */
imxf029       varchar2(10)      ,/* 容量單位 */
imxf030       number(20,6)      ,/* 超量容差(%) */
imxf031       number(20,6)      ,/* 載重量 */
imxf032       varchar2(10)      ,/* 載重單位 */
imxf033       number(20,6)      ,/* 超重容差(%) */
imxf034       varchar2(10)      ,/* 料號來源 */
imxf035       varchar2(40)      ,/* 來源參考料號 */
imxf036       varchar2(1)      ,/* 紀錄組裝位置(插件) */
imxf037       varchar2(1)      ,/* 組裝位置須勾稽 */
imxf038       varchar2(1)      ,/* 工程料件 */
imxf039       varchar2(40)      ,/* 轉正式料號 */
imxf040       date      ,/* 轉正式料號時間 */
imxf041       varchar2(255)      ,/* 工程圖號 */
imxf042       varchar2(20)      ,/* 主要模具編號 */
imxf043       varchar2(10)      ,/* 主要材質 */
imxf044       varchar2(10)      ,/* AVL控管點 */
imxf045       varchar2(10)      ,/* 生產國家地區 */
imxf100       varchar2(10)      ,/* 條碼類型 */
imxf101       varchar2(10)      ,/* 主供應商 */
imxf102       number(5,0)      ,/* 保質期(月) */
imxf103       number(5,0)      ,/* 保質期(天) */
imxf104       varchar2(10)      ,/* 庫存單位 */
imxf105       varchar2(10)      ,/* 銷售單位 */
imxf106       varchar2(10)      ,/* 銷售計價單位 */
imxf107       varchar2(10)      ,/* 採購單位 */
imxf108       varchar2(10)      ,/* 商品種類 */
imxf109       varchar2(10)      ,/* 商品性質 */
imxf110       varchar2(1)      ,/* 季節性商品 */
imxf111       date      ,/* 開始日期 */
imxf112       date      ,/* 結束日期 */
imxf113       number(5,0)      ,/* 價格因子 */
imxf114       varchar2(10)      ,/* 計價幣別 */
imxf115       number(20,6)      ,/* 預計進貨價格 */
imxf116       number(20,6)      ,/* 預計銷貨價格 */
imxf117       number(20,6)      ,/* 進銷差率 */
imxf118       number(15,3)      ,/* 試銷期(天) */
imxf119       number(20,6)      ,/* 試銷金額 */
imxf120       number(15,3)      ,/* 試銷數量 */
imxf121       varchar2(1)      ,/* 是否網路經營 */
imxf122       varchar2(10)      ,/* 產地分類 */
imxf123       varchar2(80)      ,/* 產地說明 */
imxf124       varchar2(10)      ,/* 進銷項稅目 */
imxf125       varchar2(10)      ,/* 一次性商品 */
imxf126       varchar2(10)      ,/* 品牌 */
imxf127       varchar2(10)      ,/* 系列 */
imxf128       varchar2(10)      ,/* 型別 */
imxf129       varchar2(10)      ,/* 功能 */
imxf130       varchar2(80)      ,/* 成份 */
imxf131       varchar2(10)      ,/* 價格帶 */
imxf132       varchar2(10)      ,/* 其它屬性一 */
imxf133       varchar2(10)      ,/* 其它屬性二 */
imxf134       varchar2(10)      ,/* 其它屬性三 */
imxf135       varchar2(10)      ,/* 其它屬性四 */
imxf136       varchar2(10)      ,/* 其它屬性五 */
imxf137       varchar2(10)      ,/* 其它屬性六 */
imxf138       varchar2(10)      ,/* 其它屬性七 */
imxf139       varchar2(10)      ,/* 其它屬性八 */
imxf140       varchar2(10)      ,/* 其它屬性九 */
imxf141       varchar2(10)      ,/* 其它屬性十 */
imxf142       varchar2(5)      ,/* 制定組織 */
imxfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imxfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imxfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imxfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imxfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imxfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imxfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imxfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imxfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imxfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imxfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imxfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imxfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imxfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imxfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imxfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imxfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imxfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imxfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imxfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imxfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imxfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imxfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imxfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imxfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imxfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imxfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imxfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imxfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imxfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imxf_t add constraint imxf_pk primary key (imxfent,imxf001) enable validate;

create unique index imxf_pk on imxf_t (imxfent,imxf001);

grant select on imxf_t to tiptop;
grant update on imxf_t to tiptop;
grant delete on imxf_t to tiptop;
grant insert on imxf_t to tiptop;

exit;
