/* 
================================================================================
檔案代號:oofb_t
檔案名稱:聯絡地址檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oofb_t
(
oofbstus       varchar2(10)      ,/* 狀態碼 */
oofbent       number(5)      ,/* 企業編號 */
oofb001       varchar2(20)      ,/* 聯絡地址識別碼 */
oofb002       varchar2(20)      ,/* 聯絡對象識別碼 */
oofb003       varchar2(40)      ,/* 聯絡對象代碼一 */
oofb004       varchar2(40)      ,/* 聯絡對象代碼二 */
oofb005       varchar2(40)      ,/* 聯絡對象代碼三 */
oofb006       varchar2(40)      ,/* 聯絡對象代碼四 */
oofb007       varchar2(40)      ,/* 聯絡對象代碼五 */
oofb008       varchar2(10)      ,/* 地址類型 */
oofb009       varchar2(10)      ,/* 地址應用分類 */
oofb010       varchar2(1)      ,/* 主要聯絡地址 */
oofb011       varchar2(80)      ,/* 簡要說明 */
oofb012       varchar2(10)      ,/* 國家/地區 */
oofb013       varchar2(12)      ,/* 郵政編號 */
oofb014       varchar2(10)      ,/* 州/省/直轄市 */
oofb015       varchar2(10)      ,/* 縣/市 */
oofb016       varchar2(10)      ,/* 行政區域 */
oofb017       varchar2(4000)      ,/* 地址 */
oofb018       date      ,/* 失效日期 */
oofbownid       varchar2(20)      ,/* 資料所有者 */
oofbowndp       varchar2(10)      ,/* 資料所屬部門 */
oofbcrtid       varchar2(20)      ,/* 資料建立者 */
oofbcrtdp       varchar2(10)      ,/* 資料建立部門 */
oofbcrtdt       timestamp(0)      ,/* 資料創建日 */
oofbmodid       varchar2(20)      ,/* 資料修改者 */
oofbmoddt       timestamp(0)      ,/* 最近修改日 */
oofb019       varchar2(10)      ,/* 簡要代碼 */
oofb020       varchar2(40)      ,/* 經度 */
oofb021       varchar2(40)      ,/* 維度 */
oofb022       varchar2(10)      ,/* 收貨站點 */
oofbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oofbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oofbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oofbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oofbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oofbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oofbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oofbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oofbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oofbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oofbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oofbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oofbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oofbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oofbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oofbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oofbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oofbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oofbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oofbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oofbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oofbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oofbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oofbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oofbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oofbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oofbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oofbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oofbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oofbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
oofb023       varchar2(10)      /* 聯絡對象類型 */
);
alter table oofb_t add constraint oofb_pk primary key (oofbent,oofb001) enable validate;

create  index oofb_01 on oofb_t (oofb002);
create  index oofb_02 on oofb_t (oofb003,oofb004,oofb005,oofb006,oofb007);
create unique index oofb_pk on oofb_t (oofbent,oofb001);
create  index oofc_03 on oofb_t (oofb013);

grant select on oofb_t to tiptop;
grant update on oofb_t to tiptop;
grant delete on oofb_t to tiptop;
grant insert on oofb_t to tiptop;

exit;
