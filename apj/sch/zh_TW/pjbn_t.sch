/* 
================================================================================
檔案代號:pjbn_t
檔案名稱:專案資料變更單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table pjbn_t
(
pjbnent       number(5)      ,/* 企業編號 */
pjbn000       varchar2(10)      ,/* 專案類型 */
pjbn001       varchar2(20)      ,/* 專案編號 */
pjbn002       varchar2(1)      ,/* 範本 */
pjbn003       varchar2(20)      ,/* 範本專案編號 */
pjbn004       varchar2(10)      ,/* 專案計算幣別 */
pjbn005       date      ,/* 立案日期 */
pjbn006       varchar2(255)      ,/* 備註 */
pjbn007       varchar2(10)      ,/* WBS計畫起始/截止日遇非工作日的處理方式 */
pjbn008       varchar2(5)      ,/* 參考行事曆參照表號 */
pjbn009       number(10,0)      ,/* 版次 */
pjbn900       number(10,0)      ,/* 變更序 */
pjbn901       varchar2(1)      ,/* 變更類型 */
pjbn902       date      ,/* 變更日期 */
pjbn903       varchar2(10)      ,/* 變更理由 */
pjbn904       varchar2(255)      ,/* 變更備註 */
pjbnownid       varchar2(20)      ,/* 資料所有者 */
pjbnowndp       varchar2(10)      ,/* 資料所有部門 */
pjbncrtid       varchar2(20)      ,/* 資料建立者 */
pjbncrtdp       varchar2(10)      ,/* 資料建立部門 */
pjbncrtdt       timestamp(0)      ,/* 資料創建日 */
pjbnmodid       varchar2(20)      ,/* 資料修改者 */
pjbnmoddt       timestamp(0)      ,/* 最近修改日 */
pjbncnfid       varchar2(20)      ,/* 資料確認者 */
pjbncnfdt       timestamp(0)      ,/* 資料確認日 */
pjbnstus       varchar2(10)      ,/* 狀態碼 */
pjbnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbnud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjbn010       varchar2(10)      ,/* 專案進度 */
pjbn011       varchar2(1)      ,/* 專案結案 */
pjbn012       varchar2(20)      ,/* 結案人員 */
pjbn013       timestamp(0)      ,/* 結案日期 */
pjbn014       varchar2(10)      ,/* 結案理由碼 */
pjbn015       varchar2(20)      ,/* 作業代號 */
pjbn016       varchar2(10)      ,/* 認列方式 */
pjbn017       number(20,6)      ,/* 本幣預算金額(未稅) */
pjbn018       number(20,6)      ,/* 本幣合同金額(未稅) */
pjbn019       number(20,6)      ,/* 本幣預算合約金額(含稅) */
pjbn020       number(20,6)      ,/* 本幣合同金額(含稅) */
pjbn021       number(10,0)      ,/* 報價版本 */
pjbn022       varchar2(10)      ,/* 結案階段設定 */
pjbn023       varchar2(10)      ,/* 結案狀態 */
pjbn024       date      ,/* 財會結案日 */
pjbn025       date      ,/* 保固結案日 */
pjbn026       varchar2(20)      ,/* 最終業主 */
pjbn027       varchar2(10)      ,/* 人工分攤選項 */
pjbn028       varchar2(1)      ,/* 請款確認單是否籤回 */
pjbn029       date      ,/* 籤回日 */
pjbn030       varchar2(1)      ,/* 保固切結書是否籤回 */
pjbn031       date      ,/* 籤回日 */
pjbn032       date      ,/* 保固起始日期 */
pjbn033       date      ,/* 保固截止日期 */
pjbn034       number(20,6)      ,/* 估列保固成本 */
pjbn035       varchar2(255)      ,/* 備註 */
pjbn036       varchar2(1)      ,/* 檢核否 */
pjbn037       number(20,6)      ,/* 估列材料 */
pjbn038       number(20,6)      ,/* 估列工包 */
pjbn039       number(20,6)      ,/* 估列費用 */
pjbn040       number(20,6)      ,/* 估列總計 */
pjbn041       varchar2(1)      ,/* 檢驗否 */
pjbn042       number(20,6)      ,/* 估列材料 */
pjbn043       number(20,6)      ,/* 估列工包 */
pjbn044       number(20,6)      ,/* 估列費用 */
pjbn045       number(20,6)      ,/* 估列總計 */
pjbn046       varchar2(1)      ,/* 檢驗否 */
pjbn047       number(20,6)      ,/* 估列材料 */
pjbn048       number(20,6)      ,/* 估列工包 */
pjbn049       number(20,6)      ,/* 估列費用 */
pjbn050       number(20,6)      ,/* 估列總計 */
pjbn051       varchar2(1)      ,/* 檢驗否 */
pjbn052       number(20,6)      ,/* 項目預估成本-材料 */
pjbn053       number(20,6)      ,/* 項目預估成本-人工 */
pjbn054       number(20,6)      ,/* 項目預估成本-加工費 */
pjbn055       number(20,6)      ,/* 項目預估成本-制費一 */
pjbn056       number(20,6)      ,/* 項目預估成本-制費二 */
pjbn057       number(20,6)      ,/* 項目預估成本-制費三 */
pjbn058       number(20,6)      ,/* 項目預估成本-制費四 */
pjbn059       number(20,6)      /* 項目預估成本-制費五 */
);
alter table pjbn_t add constraint pjbn_pk primary key (pjbnent,pjbn001,pjbn900) enable validate;

create unique index pjbn_pk on pjbn_t (pjbnent,pjbn001,pjbn900);

grant select on pjbn_t to tiptop;
grant update on pjbn_t to tiptop;
grant delete on pjbn_t to tiptop;
grant insert on pjbn_t to tiptop;

exit;
