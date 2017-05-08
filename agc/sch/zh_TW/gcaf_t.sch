/* 
================================================================================
檔案代號:gcaf_t
檔案名稱:券種基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gcaf_t
(
gcafent       number(5)      ,/* 企業編號 */
gcafunit       varchar2(10)      ,/* 應用組織 */
gcaf001       varchar2(10)      ,/* 券種編號 */
gcaf002       varchar2(10)      ,/* 版本 */
gcaf003       varchar2(10)      ,/* 券種類別 */
gcaf004       varchar2(10)      ,/* 券種型式 */
gcaf005       number(20,6)      ,/* 券預計發行總金額 */
gcaf006       number(5,0)      ,/* 券號總碼長 */
gcaf007       number(5,0)      ,/* 券號固定編號長度 */
gcaf008       varchar2(40)      ,/* 券號固定編號 */
gcaf009       number(5,0)      ,/* 券號流水碼長度 */
gcaf010       varchar2(30)      ,/* 起始券號 */
gcaf011       varchar2(30)      ,/* 結束券號 */
gcaf012       varchar2(10)      ,/* 券面額編號 */
gcaf013       varchar2(40)      ,/* 券對應商品編號 */
gcaf014       varchar2(256)      ,/* 產品特徵 */
gcaf015       varchar2(1)      ,/* 需產生券號明細資訊 */
gcaf016       varchar2(1)      ,/* 券效期控管 */
gcaf017       varchar2(10)      ,/* 效期規則起算基準 */
gcaf018       varchar2(10)      ,/* 有效期至 */
gcaf019       date      ,/* 效期指定日期 */
gcaf020       number(5,0)      ,/* 效期指定長度 */
gcaf021       varchar2(1)      ,/* 允許找零 */
gcaf022       varchar2(10)      ,/* 找零方式 */
gcaf023       number(20,6)      ,/* 最大找零金額 */
gcaf024       varchar2(10)      ,/* 發票開立方式 */
gcaf025       varchar2(10)      ,/* 券核銷方式 */
gcaf026       varchar2(1)      ,/* 納入遞延收入計算 */
gcaf027       varchar2(1)      ,/* 限會員收券 */
gcaf028       varchar2(1)      ,/* 促銷可收券 */
gcaf029       varchar2(10)      ,/* 折價券收券比例條件 */
gcaf030       varchar2(10)      ,/* 額滿/量滿 */
gcaf031       varchar2(10)      ,/* 對應款別編號 */
gcafownid       varchar2(20)      ,/* 資料所有者 */
gcafowndp       varchar2(10)      ,/* 資料所有部門 */
gcafcrtid       varchar2(20)      ,/* 資料建立者 */
gcafcrtdp       varchar2(10)      ,/* 資料建立部門 */
gcafcrtdt       timestamp(0)      ,/* 資料創建日 */
gcafmodid       varchar2(20)      ,/* 資料修改者 */
gcafmoddt       timestamp(0)      ,/* 最近修改日 */
gcafcnfid       varchar2(20)      ,/* 資料確認者 */
gcafcnfdt       timestamp(0)      ,/* 資料確認日 */
gcafstus       varchar2(10)      ,/* 狀態碼 */
gcaf032       varchar2(10)      ,/* 券異動明細產生方式 */
gcafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcafud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gcaf033       varchar2(10)      ,/* 銷售認列方式 */
gcaf034       varchar2(1)      ,/* 前台小票列印否 */
gcaf035       varchar2(1000)      ,/* 列印內容 */
gcaf036       varchar2(1)      ,/* 積分否 */
gcaf037       varchar2(10)      ,/* 啓用校驗碼 */
gcaf038       varchar2(1)      ,/* 輸入券號否 */
gcaf039       number(20,6)      ,/* 售券默認折扣 */
gcaf040       varchar2(10)      ,/* 券消費認列方式 */
gcaf041       varchar2(10)      ,/* 已開發票禮券稅別 */
gcaf042       date      ,/* 生效日期 */
gcaf043       varchar2(1)      ,/* 是否不規則券號 */
gcaf044       varchar2(1)      ,/* 與其他券種同時使用否 */
gcaf045       varchar2(1)      /* 參加促銷金額否 */
);
alter table gcaf_t add constraint gcaf_pk primary key (gcafent,gcaf001) enable validate;

create unique index gcaf_pk on gcaf_t (gcafent,gcaf001);

grant select on gcaf_t to tiptop;
grant update on gcaf_t to tiptop;
grant delete on gcaf_t to tiptop;
grant insert on gcaf_t to tiptop;

exit;
