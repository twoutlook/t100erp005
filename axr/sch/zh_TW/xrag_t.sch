/* 
================================================================================
檔案代號:xrag_t
檔案名稱:遞延認列依帳套設定單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xrag_t
(
xragent       number(5)      ,/* 企業代碼 */
xragld       varchar2(5)      ,/* 帳套 */
xragud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xragud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xragud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xragud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xragud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xragud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xragud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xragud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xragud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xragud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xragud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xragud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xragud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xragud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xragud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xragud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xragud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xragud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xragud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xragud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xragud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xragud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xragud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xragud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xragud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xragud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xragud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xragud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xragud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xragud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrag_t add constraint xrag_pk primary key (xragent,xragld) enable validate;

create unique index xrag_pk on xrag_t (xragent,xragld);

grant select on xrag_t to tiptop;
grant update on xrag_t to tiptop;
grant delete on xrag_t to tiptop;
grant insert on xrag_t to tiptop;

exit;
