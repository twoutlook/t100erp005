/* 
================================================================================
檔案代號:sfha_t
檔案名稱:當站下線單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table sfha_t
(
sfhaent       number(5)      ,/* 企業編號 */
sfhasite       varchar2(10)      ,/* 營運據點 */
sfhadocno       varchar2(20)      ,/* 單據編號 */
sfhadocdt       date      ,/* 單據日期 */
sfha001       date      ,/* 過帳日期 */
sfha002       varchar2(20)      ,/* 申請人員 */
sfha003       varchar2(10)      ,/* 部門 */
sfha004       varchar2(20)      ,/* 工單單號 */
sfha005       number(10,0)      ,/* Run Card */
sfha006       varchar2(10)      ,/* 作業編號 */
sfha007       varchar2(10)      ,/* 製程序 */
sfha008       number(20,6)      ,/* 當站下線數量 */
sfha009       varchar2(255)      ,/* 備註 */
sfha010       varchar2(20)      ,/* 來源單號 */
sfha011       number(10,0)      ,/* 來源單號項次 */
sfha012       varchar2(10)      ,/* 生產計畫 */
sfha013       varchar2(40)      ,/* 生產料號 */
sfha014       varchar2(30)      ,/* BOM特性 */
sfha015       varchar2(256)      ,/* 產品特徵 */
sfhaownid       varchar2(20)      ,/* 資料所有者 */
sfhaowndp       varchar2(10)      ,/* 資料所屬部門 */
sfhacrtid       varchar2(20)      ,/* 資料建立者 */
sfhacrtdp       varchar2(10)      ,/* 資料建立部門 */
sfhacrtdt       timestamp(0)      ,/* 資料創建日 */
sfhamodid       varchar2(20)      ,/* 資料修改者 */
sfhamoddt       timestamp(0)      ,/* 最近修改日 */
sfhacnfid       varchar2(20)      ,/* 資料確認者 */
sfhacnfdt       timestamp(0)      ,/* 資料確認日 */
sfhapstid       varchar2(20)      ,/* 資料過帳者 */
sfhapstdt       timestamp(0)      ,/* 資料過帳日 */
sfhastus       varchar2(10)      ,/* 狀態碼 */
sfha016       varchar2(10)      ,/* 原因碼 */
sfhaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfhaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfhaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfhaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfhaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfhaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfhaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfhaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfhaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfhaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfhaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfhaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfhaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfhaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfhaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfhaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfhaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfhaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfhaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfhaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfhaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfhaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfhaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfhaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfhaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfhaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfhaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfhaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfhaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfhaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfha_t add constraint sfha_pk primary key (sfhaent,sfhadocno) enable validate;

create unique index sfha_pk on sfha_t (sfhaent,sfhadocno);

grant select on sfha_t to tiptop;
grant update on sfha_t to tiptop;
grant delete on sfha_t to tiptop;
grant insert on sfha_t to tiptop;

exit;
