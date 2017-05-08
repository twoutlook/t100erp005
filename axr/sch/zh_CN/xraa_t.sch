/* 
================================================================================
檔案代號:xraa_t
檔案名稱:款別設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xraa_t
(
xraaent       number(5)      ,/* 企業編號 */
xraasite       varchar2(10)      ,/* 營運據點 */
xraa001       number(5)      ,/* 應用分類 */
xraa002       varchar2(10)      ,/* 款別編號 */
xraa003       varchar2(10)      ,/* 本位幣幣別 */
xraa004       varchar2(1)      ,/* 第三方代收繳款否 */
xraa005       varchar2(1)      ,/* 產生代收帳款單否 */
xraa006       varchar2(10)      ,/* 代收機構 */
xraa007       number(20,10)      ,/* 預設手續費費率 */
xraa008       number(15,3)      ,/* 預設手續費單筆金額 */
xraa009       varchar2(15)      ,/* 歸屬銀存帳戶 */
xraa010       varchar2(1)      ,/* 已納增值稅(發行已含稅的有價券) */
xraaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xraaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xraaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xraaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xraaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xraaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xraaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xraaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xraaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xraaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xraaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xraaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xraaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xraaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xraaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xraaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xraaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xraaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xraaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xraaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xraaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xraaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xraaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xraaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xraaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xraaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xraaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xraaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xraaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xraaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xraa_t add constraint xraa_pk primary key (xraaent,xraasite,xraa001,xraa002) enable validate;

create  index xraa_01 on xraa_t (xraa005);
create  index xraa_02 on xraa_t (xraa008);
create unique index xraa_pk on xraa_t (xraaent,xraasite,xraa001,xraa002);

grant select on xraa_t to tiptop;
grant update on xraa_t to tiptop;
grant delete on xraa_t to tiptop;
grant insert on xraa_t to tiptop;

exit;
