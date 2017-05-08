/* 
================================================================================
檔案代號:fmmf_t
檔案名稱:交易市場組織資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fmmf_t
(
fmmfent       number(5)      ,/* 企業編號 */
fmmf001       varchar2(10)      ,/* 投資組織 */
fmmf002       varchar2(10)      ,/* 交易市場編號 */
fmmf003       varchar2(30)      ,/* 資金帳戶 */
fmmf004       varchar2(15)      ,/* 三方存管銀行 */
fmmf005       varchar2(30)      ,/* 三方存管銀行帳戶 */
fmmf006       varchar2(24)      ,/* NO USE */
fmmfownid       varchar2(20)      ,/* 資料所有者 */
fmmfowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmfcrtid       varchar2(20)      ,/* 資料建立者 */
fmmfcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmfcrtdt       timestamp(0)      ,/* 資料創建日 */
fmmfmodid       varchar2(20)      ,/* 資料修改者 */
fmmfmoddt       timestamp(0)      ,/* 最近修改日 */
fmmfstus       varchar2(10)      ,/* 狀態碼 */
fmmfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmmf_t add constraint fmmf_pk primary key (fmmfent,fmmf001,fmmf002) enable validate;

create unique index fmmf_pk on fmmf_t (fmmfent,fmmf001,fmmf002);

grant select on fmmf_t to tiptop;
grant update on fmmf_t to tiptop;
grant delete on fmmf_t to tiptop;
grant insert on fmmf_t to tiptop;

exit;
