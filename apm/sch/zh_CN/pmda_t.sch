/* 
================================================================================
檔案代號:pmda_t
檔案名稱:請購單單頭頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmda_t
(
pmdaent       number(5)      ,/* 企業編號 */
pmdaownid       varchar2(20)      ,/* 資料所有者 */
pmdaowndp       varchar2(10)      ,/* 資料所屬部門 */
pmdacrtid       varchar2(20)      ,/* 資料建立者 */
pmdacrtdp       varchar2(10)      ,/* 資料建立部門 */
pmdacrtdt       timestamp(0)      ,/* 資料創建日 */
pmdamodid       varchar2(20)      ,/* 資料修改者 */
pmdamoddt       timestamp(0)      ,/* 最近修改日 */
pmdacnfid       varchar2(20)      ,/* 資料確認者 */
pmdacnfdt       timestamp(0)      ,/* 資料確認日 */
pmdapstid       varchar2(20)      ,/* 資料過帳者 */
pmdapstdt       timestamp(0)      ,/* 資料過帳日 */
pmdastus       varchar2(10)      ,/* 狀態碼 */
pmdasite       varchar2(10)      ,/* 營運據點 */
pmdadocno       varchar2(20)      ,/* 請購單號 */
pmdadocdt       date      ,/* 請購日期 */
pmda001       number(5,0)      ,/* 版次 */
pmda002       varchar2(20)      ,/* 請購人員 */
pmda003       varchar2(10)      ,/* 請購部門 */
pmda004       varchar2(1)      ,/* 單價為必要輸入 */
pmda005       varchar2(10)      ,/* 幣別 */
pmda006       varchar2(1)      ,/* No Use */
pmda007       varchar2(10)      ,/* 費用部門 */
pmda008       number(20,6)      ,/* 請購總未稅金額 */
pmda009       number(20,6)      ,/* 請購總含稅金額 */
pmda010       varchar2(10)      ,/* 稅別 */
pmda011       number(5,2)      ,/* 稅率 */
pmda012       varchar2(1)      ,/* 單價含稅否 */
pmda020       varchar2(1)      ,/* 納入 MPS/MRP計算 */
pmda021       varchar2(10)      ,/* 運送方式 */
pmda022       varchar2(255)      ,/* 備註 */
pmda200       varchar2(10)      ,/* 來源類型 */
pmda201       varchar2(10)      ,/* 採購方式 */
pmda202       varchar2(10)      ,/* 所屬品類 */
pmda203       varchar2(10)      ,/* 需求組織 */
pmda204       varchar2(10)      ,/* 採購中心 */
pmda205       varchar2(10)      ,/* 配送中心 */
pmda206       varchar2(10)      ,/* 配送倉 */
pmda207       date      ,/* 到貨日期 */
pmda208       number(20,6)      ,/* 包裝總數量 */
pmda900       number(20,6)      ,/* 保留欄位str */
pmda999       number(20,6)      ,/* 保留欄位end */
pmdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmda023       varchar2(10)      ,/* 留置原因 */
pmda024       varchar2(10)      ,/* 送貨地址 */
pmda025       varchar2(10)      /* 帳款地址 */
);
alter table pmda_t add constraint pmda_pk primary key (pmdaent,pmdadocno) enable validate;

create unique index pmda_pk on pmda_t (pmdaent,pmdadocno);

grant select on pmda_t to tiptop;
grant update on pmda_t to tiptop;
grant delete on pmda_t to tiptop;
grant insert on pmda_t to tiptop;

exit;
