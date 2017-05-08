/* 
================================================================================
檔案代號:rtaj_t
檔案名稱:條碼規則解析資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtaj_t
(
rtajent       number(5)      ,/* 企業編號 */
rtaj001       varchar2(10)      ,/* 條碼分類 */
rtaj002       varchar2(10)      ,/* 字頭 */
rtaj003       varchar2(10)      ,/* 長度 */
rtaj004       varchar2(10)      ,/* 金額單位 */
rtaj005       varchar2(10)      ,/* 重量單位 */
rtaj006       varchar2(10)      ,/* 價格單位 */
rtaj007       varchar2(40)      ,/* 自定義條碼格式 */
rtaj008       varchar2(80)      ,/* 格式說明 */
rtaj009       number(5,0)      ,/* 字頭起始位 */
rtaj010       number(5,0)      ,/* 字頭截止位 */
rtaj011       number(5,0)      ,/* 流水碼起始位 */
rtaj012       number(5,0)      ,/* 流水碼截止位 */
rtaj013       number(5,0)      ,/* 金額碼起始位 */
rtaj014       number(5,0)      ,/* 金額碼截止位 */
rtaj015       number(5,0)      ,/* 重量碼起始位 */
rtaj016       number(5,0)      ,/* 重量碼截止位 */
rtaj017       number(5,0)      ,/* 價格碼起始位 */
rtaj018       number(5,0)      ,/* 價格碼截止位 */
rtaj019       number(5,0)      ,/* 校驗碼起始位 */
rtaj020       number(5,0)      ,/* 校驗碼截止位 */
rtaj021       varchar2(40)      ,/* 最大條碼編號 */
rtajstamp       timestamp(5)      ,/* 時間戳記 */
rtajstus       varchar2(10)      ,/* 狀態碼 */
rtajownid       varchar2(20)      ,/* 資料所有者 */
rtajowndp       varchar2(10)      ,/* 資料所屬部門 */
rtajcrtid       varchar2(20)      ,/* 資料建立者 */
rtajcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtajcrtdt       timestamp(0)      ,/* 資料創建日 */
rtajmodid       varchar2(20)      ,/* 資料修改者 */
rtajmoddt       timestamp(0)      ,/* 最近修改日 */
rtajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtajud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtaj_t add constraint rtaj_pk primary key (rtajent,rtaj001) enable validate;

create unique index rtaj_pk on rtaj_t (rtajent,rtaj001);

grant select on rtaj_t to tiptop;
grant update on rtaj_t to tiptop;
grant delete on rtaj_t to tiptop;
grant insert on rtaj_t to tiptop;

exit;
