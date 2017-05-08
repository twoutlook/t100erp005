/* 
================================================================================
檔案代號:bmfp_t
檔案名稱:ECN多主件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfp_t
(
bmfpent       number(5)      ,/* 企業編號 */
bmfpsite       varchar2(10)      ,/* 營運據點 */
bmfpdocno       varchar2(20)      ,/* ECN單號 */
bmfp002       varchar2(40)      ,/* 主件料號 */
bmfp003       varchar2(30)      ,/* 特性 */
bmfp004       varchar2(10)      ,/* 舊生命週期 */
bmfp005       varchar2(10)      ,/* 新生命週期 */
bmfp006       varchar2(10)      ,/* 舊版本 */
bmfp007       varchar2(10)      ,/* 新版本 */
bmfpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfpud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
bmfp008       varchar2(10)      ,/* 舊生產單位 */
bmfp009       varchar2(10)      /* 新生產單位 */
);
alter table bmfp_t add constraint bmfp_pk primary key (bmfpent,bmfpsite,bmfpdocno,bmfp002,bmfp003) enable validate;

create unique index bmfp_pk on bmfp_t (bmfpent,bmfpsite,bmfpdocno,bmfp002,bmfp003);

grant select on bmfp_t to tiptop;
grant update on bmfp_t to tiptop;
grant delete on bmfp_t to tiptop;
grant insert on bmfp_t to tiptop;

exit;
