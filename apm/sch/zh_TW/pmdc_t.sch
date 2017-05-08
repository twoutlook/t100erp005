/* 
================================================================================
檔案代號:pmdc_t
檔案名稱:請購變更單單頭頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmdc_t
(
pmdcent       number(5)      ,/* 企業編號 */
pmdcsite       varchar2(10)      ,/* 營運據點 */
pmdcdocno       varchar2(20)      ,/* 請購單號 */
pmdcdocdt       date      ,/* 請購日期 */
pmdcacti       varchar2(1)      ,/* 請購單結案否 */
pmdc001       number(10,0)      ,/* 版次 */
pmdc002       varchar2(20)      ,/* 請購人員 */
pmdc003       varchar2(10)      ,/* 請購部門 */
pmdc004       varchar2(1)      ,/* 單價為必要輸入 */
pmdc005       varchar2(10)      ,/* 幣別 */
pmdc006       varchar2(1)      ,/* 預算控管否 */
pmdc007       varchar2(10)      ,/* 費用部門 */
pmdc008       number(20,6)      ,/* 請購總未稅金額 */
pmdc009       number(20,6)      ,/* 請購總含稅金額 */
pmdc010       varchar2(10)      ,/* 稅別 */
pmdc011       number(5,2)      ,/* 稅率 */
pmdc012       varchar2(1)      ,/* 單價含稅否 */
pmdc020       varchar2(1)      ,/* 納入 MPS/MRP計算 */
pmdc021       varchar2(10)      ,/* 運送方式 */
pmdc022       varchar2(255)      ,/* 備註 */
pmdc200       varchar2(10)      ,/* 來源類型 */
pmdc201       varchar2(10)      ,/* 採購方式 */
pmdc202       varchar2(10)      ,/* 所屬品類 */
pmdc203       varchar2(10)      ,/* 需求組織 */
pmdc204       varchar2(10)      ,/* 採購中心 */
pmdc205       varchar2(10)      ,/* 配送中心 */
pmdc206       varchar2(10)      ,/* 配送倉 */
pmdc207       date      ,/* 到貨日期 */
pmdc208       number(20,6)      ,/* 包裝總數量 */
pmdc900       number(10,0)      ,/* 變更序 */
pmdc901       varchar2(1)      ,/* 變更類型 */
pmdc902       date      ,/* 變更日期 */
pmdc905       varchar2(10)      ,/* 變更理由 */
pmdc906       varchar2(255)      ,/* 變更備註 */
pmdcownid       varchar2(20)      ,/* 資料所有者 */
pmdcowndp       varchar2(10)      ,/* 資料所屬部門 */
pmdccrtid       varchar2(20)      ,/* 資料建立者 */
pmdccrtdp       varchar2(10)      ,/* 資料建立部門 */
pmdccrtdt       timestamp(0)      ,/* 資料創建日 */
pmdcmodid       varchar2(20)      ,/* 資料修改者 */
pmdcmoddt       timestamp(0)      ,/* 最近修改日 */
pmdccnfid       varchar2(20)      ,/* 資料確認者 */
pmdccnfdt       timestamp(0)      ,/* 資料確認日 */
pmdcpstid       varchar2(20)      ,/* 資料過帳者 */
pmdcpstdt       timestamp(0)      ,/* 資料過帳日 */
pmdcstus       varchar2(10)      ,/* 狀態碼 */
pmdcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmdc_t add constraint pmdc_pk primary key (pmdcent,pmdcdocno,pmdc900) enable validate;

create unique index pmdc_pk on pmdc_t (pmdcent,pmdcdocno,pmdc900);

grant select on pmdc_t to tiptop;
grant update on pmdc_t to tiptop;
grant delete on pmdc_t to tiptop;
grant insert on pmdc_t to tiptop;

exit;
