/* 
================================================================================
檔案代號:oofa_t
檔案名稱:聯絡對象檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oofa_t
(
oofastus       varchar2(10)      ,/* 狀態碼 */
oofaent       number(5)      ,/* 企業編號 */
oofa001       varchar2(20)      ,/* 聯絡對象識別碼 */
oofa002       varchar2(10)      ,/* 聯絡對象類型 */
oofa003       varchar2(40)      ,/* 聯絡對象代碼一 */
oofa004       varchar2(40)      ,/* 聯絡對象代碼二 */
oofa005       varchar2(40)      ,/* 聯絡對象代碼三 */
oofa006       varchar2(40)      ,/* 聯絡對象代碼四 */
oofa007       varchar2(40)      ,/* 聯絡對象代碼五 */
oofa008       varchar2(80)      ,/* 姓氏 */
oofa009       varchar2(80)      ,/* 中間名 */
oofa010       varchar2(80)      ,/* 名字 */
oofa011       varchar2(255)      ,/* 全名 */
oofa012       varchar2(80)      ,/* 參考名 */
oofa013       varchar2(80)      ,/* 暱稱 */
oofa014       varchar2(10)      ,/* 助記碼 */
oofa015       varchar2(20)      ,/* 識別證號 */
oofa016       varchar2(80)      ,/* 簡要說明 */
oofa017       date      ,/* 失效日期 */
oofaownid       varchar2(20)      ,/* 資料所有者 */
oofaowndp       varchar2(10)      ,/* 資料所屬部門 */
oofacrtid       varchar2(20)      ,/* 資料建立者 */
oofacrtdp       varchar2(10)      ,/* 資料建立部門 */
oofacrtdt       timestamp(0)      ,/* 資料創建日 */
oofamodid       varchar2(20)      ,/* 資料修改者 */
oofamoddt       timestamp(0)      ,/* 最近修改日 */
oofaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oofaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oofaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oofaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oofaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oofaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oofaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oofaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oofaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oofaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oofaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oofaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oofaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oofaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oofaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oofaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oofaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oofaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oofaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oofaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oofaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oofaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oofaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oofaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oofaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oofaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oofaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oofaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oofaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oofaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oofa_t add constraint oofa_pk primary key (oofaent,oofa001) enable validate;

create  index oofa_01 on oofa_t (oofa002);
create  index oofa_02 on oofa_t (oofa003,oofa004,oofa005,oofa006,oofa007);
create  index oofa_03 on oofa_t (oofa014);
create  index oofa_04 on oofa_t (oofa015);
create unique index oofa_pk on oofa_t (oofaent,oofa001);

grant select on oofa_t to tiptop;
grant update on oofa_t to tiptop;
grant delete on oofa_t to tiptop;
grant insert on oofa_t to tiptop;

exit;
