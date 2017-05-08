/* 
================================================================================
檔案代號:pmdo_t
檔案名稱:採購交期明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdo_t
(
pmdoent       number(5)      ,/* 企業編號 */
pmdosite       varchar2(10)      ,/* 營運據點 */
pmdodocno       varchar2(20)      ,/* 採購單號 */
pmdoseq       number(10,0)      ,/* 採購項次 */
pmdoseq1       number(10,0)      ,/* 項序 */
pmdoseq2       number(10,0)      ,/* 分批序 */
pmdo001       varchar2(40)      ,/* 料件編號 */
pmdo002       varchar2(256)      ,/* 產品特徵 */
pmdo003       varchar2(10)      ,/* 子件特性 */
pmdo004       varchar2(10)      ,/* 採購單位 */
pmdo005       number(20,6)      ,/* 採購總數量 */
pmdo006       number(20,6)      ,/* 分批採購數量 */
pmdo007       number(20,6)      ,/* 摺合主件數量 */
pmdo008       number(20,6)      ,/* QPA */
pmdo009       varchar2(10)      ,/* 交期類型 */
pmdo010       varchar2(10)      ,/* 收貨時段 */
pmdo011       date      ,/* 出貨日期 */
pmdo012       date      ,/* 到廠日期 */
pmdo013       date      ,/* 到庫日期 */
pmdo014       varchar2(1)      ,/* MRP交期凍結 */
pmdo015       number(20,6)      ,/* 已收貨量 */
pmdo016       number(20,6)      ,/* 驗退量 */
pmdo017       number(20,6)      ,/* 倉退換貨量 */
pmdo019       number(20,6)      ,/* 已入庫量 */
pmdo020       number(20,6)      ,/* VMI請款量 */
pmdo021       varchar2(10)      ,/* 交貨狀態 */
pmdo022       number(20,6)      ,/* 參考價格 */
pmdo023       varchar2(10)      ,/* 稅別 */
pmdo024       number(5,2)      ,/* 稅率 */
pmdo025       varchar2(20)      ,/* 電子採購單號 */
pmdo026       varchar2(20)      ,/* 最近修改人員 */
pmdo027       timestamp(0)      ,/* 最近修改時間 */
pmdo028       varchar2(10)      ,/* 分批參考單位 */
pmdo029       number(20,6)      ,/* 分批參考數量 */
pmdo030       varchar2(10)      ,/* 分批計價單位 */
pmdo031       number(20,6)      ,/* 分批計價數量 */
pmdo032       number(20,6)      ,/* 分批未稅金額 */
pmdo033       number(20,6)      ,/* 分批含稅金額 */
pmdo034       number(20,6)      ,/* 分批稅額 */
pmdo035       varchar2(10)      ,/* 初始營運據點 */
pmdo036       varchar2(20)      ,/* 初始來源單號 */
pmdo037       number(10,0)      ,/* 初始來源項次 */
pmdo038       number(10,0)      ,/* 初始項序 */
pmdo039       number(10,0)      ,/* 初始分批序 */
pmdo040       number(20,6)      ,/* 倉退量 */
pmdo200       varchar2(10)      ,/* 分批包裝單位 */
pmdo201       number(20,6)      ,/* 分批包裝數量 */
pmdo900       number(20,6)      ,/* 保留欄位str */
pmdo999       number(20,6)      ,/* 保留欄位end */
pmdoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdoud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmdo041       number(20,6)      ,/* 還料數量 */
pmdo042       number(20,6)      ,/* 還量參考數量 */
pmdo043       number(20,6)      ,/* 還價數量 */
pmdo044       number(20,6)      /* 還價參考數量 */
);
alter table pmdo_t add constraint pmdo_pk primary key (pmdoent,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2) enable validate;

create unique index pmdo_pk on pmdo_t (pmdoent,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2);

grant select on pmdo_t to tiptop;
grant update on pmdo_t to tiptop;
grant delete on pmdo_t to tiptop;
grant insert on pmdo_t to tiptop;

exit;
