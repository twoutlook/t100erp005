/* 
================================================================================
檔案代號:fmck_t
檔案名稱:融資明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmck_t
(
fmckent       number(5)      ,/* 企業代碼 */
fmckdocno       varchar2(20)      ,/* 融資合同編號 */
fmckseq       number(10,0)      ,/* 合同項次 */
fmck001       varchar2(10)      ,/* 貨款銀行 */
fmck002       varchar2(10)      ,/* 幣別 */
fmck003       varchar2(30)      ,/* 貸款帳戶 */
fmck004       number(20,6)      ,/* 金額 */
fmck005       varchar2(1)      ,/* 利率方式 */
fmck006       varchar2(1)      ,/* 浮動方式 */
fmck007       number(15,3)      ,/* 固定利率/浮動利率(年%) */
fmck008       number(15,3)      ,/* 逾期罰息率(年%) */
fmck009       number(15,3)      ,/* 挪用罰息率(年%) */
fmck010       varchar2(1)      ,/* 複利計算 */
fmck011       varchar2(20)      ,/* 融資稽覈單號 */
fmck012       number(10,0)      ,/* 融資稽覈單項次 */
fmckud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmckud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmckud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmckud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmckud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmckud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmckud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmckud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmckud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmckud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmckud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmckud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmckud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmckud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmckud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmckud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmckud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmckud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmckud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmckud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmckud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmckud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmckud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmckud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmckud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmckud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmckud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmckud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmckud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmckud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmck_t add constraint fmck_pk primary key (fmckent,fmckdocno,fmckseq) enable validate;

create unique index fmck_pk on fmck_t (fmckent,fmckdocno,fmckseq);

grant select on fmck_t to tiptop;
grant update on fmck_t to tiptop;
grant delete on fmck_t to tiptop;
grant insert on fmck_t to tiptop;

exit;
