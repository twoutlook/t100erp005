/* 
================================================================================
檔案代號:oofc_t
檔案名稱:通訊方式檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oofc_t
(
oofcstus       varchar2(10)      ,/* 狀態碼 */
oofcent       number(5)      ,/* 企業編號 */
oofc001       varchar2(20)      ,/* 通訊方式識別碼 */
oofc002       varchar2(20)      ,/* 聯絡對象識別碼 */
oofc003       varchar2(40)      ,/* 聯絡對象代碼一 */
oofc004       varchar2(40)      ,/* 聯絡對象代碼二 */
oofc005       varchar2(40)      ,/* 聯絡對象代碼三 */
oofc006       varchar2(40)      ,/* 聯絡對象代碼四 */
oofc007       varchar2(40)      ,/* 聯絡對象代碼五 */
oofc008       varchar2(10)      ,/* 通訊類型 */
oofc009       varchar2(10)      ,/* 通訊應用分類 */
oofc010       varchar2(1)      ,/* 主要通訊方式 */
oofc011       varchar2(80)      ,/* 簡要說明 */
oofc012       varchar2(255)      ,/* 通訊內容 */
oofc013       date      ,/* 失效日期 */
oofcownid       varchar2(20)      ,/* 資料所有者 */
oofcowndp       varchar2(10)      ,/* 資料所有部門 */
oofccrtid       varchar2(20)      ,/* 資料建立者 */
oofccrtdp       varchar2(10)      ,/* 資料建立部門 */
oofccrtdt       timestamp(0)      ,/* 資料創建日 */
oofcmodid       varchar2(20)      ,/* 資料修改者 */
oofcmoddt       timestamp(0)      ,/* 最近修改日 */
oofc014       varchar2(10)      ,/* 簡要代碼 */
oofcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oofcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oofcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oofcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oofcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oofcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oofcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oofcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oofcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oofcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oofcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oofcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oofcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oofcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oofcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oofcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oofcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oofcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oofcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oofcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oofcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oofcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oofcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oofcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oofcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oofcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oofcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oofcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oofcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oofcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
oofc015       varchar2(1)      ,/* 寄發郵件 */
oofc016       varchar2(10)      /* 聯絡對象類型 */
);
alter table oofc_t add constraint oofc_pk primary key (oofcent,oofc001) enable validate;

create  index oofc_01 on oofc_t (oofc002);
create  index oofc_02 on oofc_t (oofc003,oofc004,oofc005,oofc006,oofc007);
create unique index oofc_pk on oofc_t (oofcent,oofc001);

grant select on oofc_t to tiptop;
grant update on oofc_t to tiptop;
grant delete on oofc_t to tiptop;
grant insert on oofc_t to tiptop;

exit;
