/* 
================================================================================
檔案代號:isaw_t
檔案名稱:電子發票中獎清冊檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table isaw_t
(
isawent       number(5)      ,/* 企業編碼 */
isaw001       varchar2(20)      ,/* 總公司統一編號 */
isaw002       number(5,0)      ,/* 發票所屬年度 */
isaw003       number(5,0)      ,/* 發票所屬月份 */
isaw004       varchar2(20)      ,/* 發票代碼 */
isaw005       varchar2(20)      ,/* 發票號碼 */
isaw006       varchar2(80)      ,/* 營業人名稱(賣方) */
isaw007       varchar2(20)      ,/* 營業人統一編號(賣方) */
isaw008       varchar2(4000)      ,/* 營業人地址(賣方) */
isaw009       date      ,/* 發票開立日期 */
isaw010       varchar2(8)      ,/* 發票開立時間 */
isaw011       number(20,6)      ,/* 發票金額總計 */
isaw012       varchar2(10)      ,/* 載具類別號碼 */
isaw013       varchar2(80)      ,/* 載具類別名稱 */
isaw014       varchar2(80)      ,/* 載具顯碼ID */
isaw015       varchar2(80)      ,/* 載具隱碼ID */
isaw016       varchar2(10)      ,/* 發票防偽隨機碼 */
isaw017       varchar2(1)      ,/* 中獎獎別 */
isaw018       number(20,6)      ,/* 中獎獎金 */
isaw019       varchar2(20)      ,/* 營利事業統一編號(買受人) */
isaw020       varchar2(1)      ,/* 大平臺已匯款註記 */
isaw021       varchar2(1)      ,/* 資料類別 */
isaw022       varchar2(10)      ,/* 例外代碼 */
isaw023       varchar2(10)      ,/* 列印格式 */
isaw024       varchar2(40)      ,/* 唯一識別碼 */
isaw025       varchar2(20)      ,/* 會員代碼 */
isaw026       varchar2(80)      ,/* 會員名稱 */
isaw027       varchar2(1)      ,/* 中獎通知方式 */
isaw028       varchar2(255)      ,/* 通知方式內容 */
isaw029       varchar2(1)      ,/* 發票列印碼 */
isaw030       varchar2(20)      ,/* 最後一次列印人員 */
isawcomp       varchar2(10)      ,/* 法人 */
isawsite       varchar2(10)      ,/* 營運據點 */
isawud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isawud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isawud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isawud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isawud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isawud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isawud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isawud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isawud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isawud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isawud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isawud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isawud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isawud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isawud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isawud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isawud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isawud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isawud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isawud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isawud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isawud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isawud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isawud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isawud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isawud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isawud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isawud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isawud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isawud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isaw_t add constraint isaw_pk primary key (isawent,isaw001,isaw002,isaw003,isaw004,isaw005) enable validate;

create unique index isaw_pk on isaw_t (isawent,isaw001,isaw002,isaw003,isaw004,isaw005);

grant select on isaw_t to tiptop;
grant update on isaw_t to tiptop;
grant delete on isaw_t to tiptop;
grant insert on isaw_t to tiptop;

exit;
