/* 
================================================================================
檔案代號:ooda_t
檔案名稱:申報單位檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooda_t
(
oodaent       number(5)      ,/* 企業編號 */
ooda001       varchar2(10)      ,/* 稅區別 */
ooda002       varchar2(10)      ,/* 申報單位 */
ooda003       varchar2(20)      ,/* 申報稅籍號碼 */
ooda004       varchar2(10)      ,/* 歸屬總繳申報單位 */
ooda005       varchar2(10)      ,/* 歸屬法人組織 */
ooda006       varchar2(20)      ,/* 統一編號 */
ooda007       varchar2(80)      ,/* 稅捐處全名 */
ooda008       varchar2(500)      ,/* 營業地址 */
ooda009       varchar2(80)      ,/* 對外全名 */
ooda010       number(5,0)      ,/* 已申報年度 */
ooda011       number(5,0)      ,/* 已申報月份 */
ooda012       number(5,0)      ,/* 申報月數 */
ooda013       varchar2(80)      ,/* 負責人 */
ooda014       varchar2(1)      ,/* 可修改前端拋轉的金額 */
ooda015       varchar2(10)      ,/* 資料別 */
ooda016       varchar2(10)      ,/* 縣市別 */
ooda017       varchar2(10)      ,/* 總繳代號 */
ooda018       varchar2(10)      ,/* 自行或委託辦理申報註記 */
ooda019       varchar2(20)      ,/* (代理)申報人身分證統一編號 */
ooda020       varchar2(80)      ,/* (代理)申報人姓名 */
ooda021       varchar2(20)      ,/* (代理)申報人電話 */
ooda022       varchar2(40)      ,/* (代理)申報人證書(登錄)字號 */
ooda023       varchar2(10)      ,/* (代理)申報人電話區碼 */
ooda024       varchar2(20)      ,/* (代理)申報人電話分機號碼 */
ooda025       varchar2(20)      ,/* 總機構統編 */
ooda026       varchar2(1)      ,/* 進銷資料併總公司合併申報 */
ooda027       date      ,/* 電子發票-核准日 */
ooda028       varchar2(40)      ,/* 電子發票-核准文 */
ooda029       varchar2(40)      ,/* 電子發票-核准號 */
oodastus       varchar2(10)      ,/* 狀態碼 */
oodaownid       varchar2(20)      ,/* 資料所有者 */
oodaowndp       varchar2(10)      ,/* 資料所屬部門 */
oodacrtid       varchar2(20)      ,/* 資料建立者 */
oodacrtdp       varchar2(10)      ,/* 資料建立部門 */
oodacrtdt       timestamp(0)      ,/* 資料創建日 */
oodamodid       varchar2(20)      ,/* 資料修改者 */
oodamoddt       timestamp(0)      ,/* 最近修改日 */
oodaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oodaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oodaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oodaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oodaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oodaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oodaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oodaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oodaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oodaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oodaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oodaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oodaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oodaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oodaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oodaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oodaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oodaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oodaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oodaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oodaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oodaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oodaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oodaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oodaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oodaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oodaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oodaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oodaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oodaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooda_t add constraint ooda_pk primary key (oodaent,ooda001,ooda002) enable validate;

create  index ooda_01 on ooda_t (ooda004);
create  index ooda_02 on ooda_t (ooda005);
create unique index ooda_pk on ooda_t (oodaent,ooda001,ooda002);

grant select on ooda_t to tiptop;
grant update on ooda_t to tiptop;
grant delete on ooda_t to tiptop;
grant insert on ooda_t to tiptop;

exit;
