/* 
================================================================================
檔案代號:imag_t
檔案名稱:料件據點財務檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imag_t
(
imagent       number(5)      ,/* 企業編號 */
imagsite       varchar2(10)      ,/* 法人營運據點 */
imag001       varchar2(40)      ,/* 料件編號 */
imag011       varchar2(10)      ,/* 財務分群(成本分群) */
imag012       varchar2(24)      ,/* 採購入庫借方會科 */
imag013       varchar2(40)      ,/* 成本料號 */
imag014       varchar2(10)      ,/* 成本單位 */
imag015       varchar2(10)      ,/* 成本計價方式 */
imagownid       varchar2(20)      ,/* 資料所屬者 */
imagowndp       varchar2(10)      ,/* 資料所有部門 */
imagcrtid       varchar2(20)      ,/* 資料建立者 */
imagcrtdt       timestamp(0)      ,/* 資料創建日 */
imagcrtdp       varchar2(10)      ,/* 資料建立部門 */
imagmodid       varchar2(20)      ,/* 資料修改者 */
imagmoddt       timestamp(0)      ,/* 最近修改日 */
imagcnfid       varchar2(20)      ,/* 資料確認者 */
imagcnfdt       timestamp(0)      ,/* 資料確認日 */
imagstus       varchar2(10)      ,/* 狀態碼 */
imagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imagud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
imag016       number(15,3)      ,/* 標準單位工時 */
imag017       number(15,3)      ,/* 標準單位機時 */
imag018       number(20,6)      ,/* 標準單位人工 */
imag019       number(20,6)      ,/* 標準單位制費一 */
imag020       number(20,6)      ,/* 標準單位制費二 */
imag021       number(20,6)      ,/* 標準單位制費三 */
imag022       number(20,6)      ,/* 標準單位制費四 */
imag023       number(20,6)      ,/* 標準單位制費五 */
imag024       varchar2(10)      /* 材料類型 */
);
alter table imag_t add constraint imag_pk primary key (imagent,imagsite,imag001) enable validate;

create  index imag_01 on imag_t (imag011);
create unique index imag_pk on imag_t (imagent,imagsite,imag001);

grant select on imag_t to tiptop;
grant update on imag_t to tiptop;
grant delete on imag_t to tiptop;
grant insert on imag_t to tiptop;

exit;
