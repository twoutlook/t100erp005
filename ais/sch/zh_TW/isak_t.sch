/* 
================================================================================
檔案代號:isak_t
檔案名稱:交易對象稅務基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table isak_t
(
isakent       number(5)      ,/* 企業編號 */
isak001       varchar2(10)      ,/* 交易對象代碼 */
isak002       varchar2(10)      ,/* 稅區 */
isak008       varchar2(20)      ,/* 納稅人識別號 */
isak009       varchar2(4000)      ,/* 開立發票地址 */
isak010       varchar2(20)      ,/* 開立發票電話 */
isak011       varchar2(255)      ,/* 開立發票銀行名稱 */
isak012       varchar2(30)      ,/* 開立發票銀行帳號 */
isakstus       varchar2(1)      ,/* 狀態碼 */
isakownid       varchar2(20)      ,/* 資料所有者 */
isakowndp       varchar2(10)      ,/* 資料所屬部門 */
isakcrtid       varchar2(20)      ,/* 資料建立者 */
isakcrtdp       varchar2(10)      ,/* 資料建立部門 */
isakcrtdt       timestamp(0)      ,/* 資料創建日 */
isakmodid       varchar2(20)      ,/* 資料修改者 */
isakmoddt       timestamp(0)      ,/* 最近修改日 */
isakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isakud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
isak003       varchar2(2)      ,/* 電子發票類型 */
isak004       date      /* 電子發票啟用日期 */
);
alter table isak_t add constraint isak_pk primary key (isakent,isak001,isak002) enable validate;

create unique index isak_pk on isak_t (isakent,isak001,isak002);

grant select on isak_t to tiptop;
grant update on isak_t to tiptop;
grant delete on isak_t to tiptop;
grant insert on isak_t to tiptop;

exit;
