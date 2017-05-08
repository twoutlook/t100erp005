/* 
================================================================================
檔案代號:type_t
檔案名稱:資料型態參照檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table type_t
(
blob       blob      ,/* BLOB_MEMO */
chr1       varchar2(1)      ,/* CHR1_MEMO */
chr10       varchar2(10)      ,/* CHR10_MEMO */
chr100       varchar2(100)      ,/* CHR100_MEMO */
chr1000       varchar2(1000)      ,/* CHR1000_MEMO */
chr12       varchar2(12)      ,/* CHR12_MEMO */
chr14       varchar2(14)      ,/* CHR14_MEMO */
chr18       varchar2(18)      ,/* CHR18_MEMO */
chr2       varchar2(2)      ,/* CHR2_MEMO */
chr20       varchar2(20)      ,/* CHR20_MEMO */
chr200       varchar2(200)      ,/* CHR200_MEMO */
chr21       varchar2(21)      ,/* CHR21_MEMO */
chr3       varchar2(3)      ,/* CHR3_MEMO */
chr30       varchar2(30)      ,/* CHR30_MEMO */
chr300       varchar2(300)      ,/* CHR300_MEMO */
chr37       varchar2(37)      ,/* CHR37_MEMO */
chr4       varchar2(4)      ,/* CHR4_MEMO */
chr5       varchar2(5)      ,/* CHR5_MEMO */
chr50       varchar2(50)      ,/* CHR50_MEMO */
chr500       varchar2(500)      ,/* CHR500_MEMO */
chr6       varchar2(6)      ,/* CHR6_MEMO */
chr7       varchar2(7)      ,/* CHR7_MEMO */
chr8       varchar2(8)      ,/* CHR8_MEMO */
chr9       varchar2(9)      ,/* CHR9_MEMO */
dat       date      ,/* DAT_MEMO */
num10       number(10,0)      ,/* NUM10_MEMO */
num15_3       number(15,3)      ,/* NUM15_3_MEMO */
num20       number(20,0)      ,/* NUM20_MEMO */
num20_6       number(20,6)      ,/* NUM20_6_MEMO */
num26_10       number(26,10)      ,/* NUM26_10_MEMO */
num5       number(5,0)      ,/* NUM5_MEMO */
row_id       varchar2(18)      ,/* ROW_ID_MEMO */
clob       clob      ,/* CLOB_MEMO */
chr80       varchar2(80)      ,/* CHR80 */
typeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
typeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
typeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
typeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
typeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
typeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
typeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
typeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
typeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
typeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
typeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
typeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
typeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
typeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
typeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
typeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
typeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
typeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
typeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
typeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
typeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
typeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
typeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
typeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
typeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
typeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
typeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
typeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
typeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
typeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on type_t to tiptop;
grant update on type_t to tiptop;
grant delete on type_t to tiptop;
grant insert on type_t to tiptop;

exit;
