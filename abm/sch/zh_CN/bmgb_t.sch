/* 
================================================================================
檔案代號:bmgb_t
檔案名稱:BOM群組替代元件組合檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmgb_t
(
bmgbent       number(5)      ,/* 企業編號 */
bmgbsite       varchar2(10)      ,/* 營運據點 */
bmgb001       varchar2(40)      ,/* 主件料號 */
bmgb002       varchar2(30)      ,/* 特性 */
bmgb003       varchar2(10)      ,/* 替代群組 */
bmgb004       varchar2(40)      ,/* 階層主件料號 */
bmgb005       varchar2(40)      ,/* 元件料號 */
bmgb006       varchar2(10)      ,/* 部位 */
bmgb007       varchar2(10)      ,/* 作業編號 */
bmgb008       varchar2(10)      ,/* 製程序 */
bmgb009       varchar2(1)      ,/* 主要 */
bmgbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmgbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmgbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmgbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmgbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmgbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmgbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmgbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmgbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmgbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmgbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmgbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmgbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmgbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmgbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmgbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmgbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmgbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmgbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmgbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmgbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmgbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmgbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmgbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmgbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmgbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmgbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmgbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmgbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmgbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmgb_t add constraint bmgb_pk primary key (bmgbent,bmgbsite,bmgb001,bmgb002,bmgb003,bmgb004,bmgb005,bmgb006,bmgb007,bmgb008) enable validate;

create unique index bmgb_pk on bmgb_t (bmgbent,bmgbsite,bmgb001,bmgb002,bmgb003,bmgb004,bmgb005,bmgb006,bmgb007,bmgb008);

grant select on bmgb_t to tiptop;
grant update on bmgb_t to tiptop;
grant delete on bmgb_t to tiptop;
grant insert on bmgb_t to tiptop;

exit;
