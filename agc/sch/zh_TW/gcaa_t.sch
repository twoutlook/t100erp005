/* 
================================================================================
檔案代號:gcaa_t
檔案名稱:券種基本資料申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gcaa_t
(
gcaaent       number(5)      ,/* 企業編號 */
gcaasite       varchar2(10)      ,/* 營運據點 */
gcaaunit       varchar2(10)      ,/* 應用組織 */
gcaadocdt       date      ,/* 單據日期 */
gcaadocno       varchar2(20)      ,/* 單據編號 */
gcaa000       varchar2(10)      ,/* 申請類別 */
gcaa001       varchar2(10)      ,/* 券種編號 */
gcaa002       varchar2(10)      ,/* 版本 */
gcaa003       varchar2(10)      ,/* 券種類別 */
gcaa004       varchar2(10)      ,/* 券種型式 */
gcaa005       number(20,6)      ,/* 券預計發行總金額 */
gcaa006       number(5,0)      ,/* 券號總碼長 */
gcaa007       number(5,0)      ,/* 券號固定編號長度 */
gcaa008       varchar2(40)      ,/* 券號固定編號 */
gcaa009       number(5,0)      ,/* 券號流水碼長度 */
gcaa010       varchar2(30)      ,/* 起始券號 */
gcaa011       varchar2(30)      ,/* 結束券號 */
gcaa012       varchar2(10)      ,/* 券面額編號 */
gcaa013       varchar2(40)      ,/* 券對應商品編號 */
gcaa014       varchar2(256)      ,/* 產品特徵 */
gcaa015       varchar2(1)      ,/* 需產生券號明細資訊 */
gcaa016       varchar2(1)      ,/* 券效期控管 */
gcaa017       varchar2(10)      ,/* 效期規則起算基準 */
gcaa018       varchar2(10)      ,/* 有效期至 */
gcaa019       date      ,/* 效期指定日期 */
gcaa020       number(5,0)      ,/* 效期指定長度 */
gcaa021       varchar2(1)      ,/* 允許找零 */
gcaa022       varchar2(10)      ,/* 找零方式 */
gcaa023       number(20,6)      ,/* 最大找零金額 */
gcaa024       varchar2(10)      ,/* 發票開立方式 */
gcaa025       varchar2(10)      ,/* 券核銷方式 */
gcaa026       varchar2(1)      ,/* 納入遞延收入計算 */
gcaa027       varchar2(1)      ,/* 限會員收券 */
gcaa028       varchar2(1)      ,/* 促銷可收券 */
gcaa029       varchar2(10)      ,/* 折價券收券比例條件 */
gcaa030       varchar2(10)      ,/* 額滿/量滿 */
gcaa031       varchar2(10)      ,/* 對應款別編號 */
gcaaacti       varchar2(1)      ,/* 資料有效 */
gcaaownid       varchar2(20)      ,/* 資料所有者 */
gcaaowndp       varchar2(10)      ,/* 資料所有部門 */
gcaacrtid       varchar2(20)      ,/* 資料建立者 */
gcaacrtdp       varchar2(10)      ,/* 資料建立部門 */
gcaacrtdt       timestamp(0)      ,/* 資料創建日 */
gcaamodid       varchar2(20)      ,/* 資料修改者 */
gcaamoddt       timestamp(0)      ,/* 最近修改日 */
gcaacnfid       varchar2(20)      ,/* 資料確認者 */
gcaacnfdt       timestamp(0)      ,/* 資料確認日 */
gcaastus       varchar2(10)      ,/* 狀態碼 */
gcaa032       varchar2(10)      ,/* 券異動明細產生方式 */
gcaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcaaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gcaa033       varchar2(10)      ,/* 銷售認列方式 */
gcaa034       varchar2(1)      ,/* 前台小票列印 */
gcaa035       varchar2(1000)      ,/* 列印內容 */
gcaa036       varchar2(1)      ,/* 積分否 */
gcaa037       varchar2(10)      ,/* 啓用校驗碼 */
gcaa038       varchar2(1)      ,/* 輸入券號否 */
gcaa039       number(20,6)      ,/* 售券默認折扣 */
gcaa040       varchar2(10)      ,/* 券消費認列方式 */
gcaa041       varchar2(10)      ,/* 已開發票禮券稅別 */
gcaa042       date      ,/* 生效日期 */
gcaa043       varchar2(1)      ,/* 是否不規則券號 */
gcaa044       varchar2(1)      ,/* 與其他券種同時使用否 */
gcaa045       varchar2(1)      /* 參加促銷金額否 */
);
alter table gcaa_t add constraint gcaa_pk primary key (gcaaent,gcaadocno) enable validate;

create unique index gcaa_pk on gcaa_t (gcaaent,gcaadocno);

grant select on gcaa_t to tiptop;
grant update on gcaa_t to tiptop;
grant delete on gcaa_t to tiptop;
grant insert on gcaa_t to tiptop;

exit;
