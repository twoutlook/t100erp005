/* 
================================================================================
檔案代號:xcdp_t
檔案名稱:本期在製成本要素調整檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xcdp_t
(
xcdpent       number(5)      ,/* 企業代碼 */
xcdpld       varchar2(5)      ,/* 帳別 */
xcdpcomp       varchar2(10)      ,/* 法人組織 */
xcdp001       varchar2(1)      ,/* 賬套本位幣順序 */
xcdp002       varchar2(30)      ,/* 成本域 */
xcdp003       varchar2(10)      ,/* 成本計算類型 */
xcdp004       number(5,0)      ,/* 年度 */
xcdp005       number(5,0)      ,/* 期別 */
xcdp006       varchar2(20)      ,/* 調整單號 */
xcdp007       varchar2(20)      ,/* 工單編號 */
xcdp008       varchar2(1)      ,/* 調整類型 */
xcdp009       varchar2(80)      ,/* 調整說明 */
xcdp010       varchar2(10)      ,/* 成本次要素 */
xcdp101       number(20,6)      ,/* 當月調整數量 */
xcdp102       number(20,6)      ,/* 當月調整金額 */
xcdpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcdpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcdpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcdpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcdpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcdpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcdpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcdpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcdpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcdpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcdpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcdpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcdpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcdpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcdpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcdpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcdpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcdpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcdpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcdpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcdpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcdpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcdpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcdpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcdpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcdpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcdpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcdpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcdpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcdpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcdp_t add constraint xcdp_pk primary key (xcdpent,xcdpld,xcdp001,xcdp003,xcdp004,xcdp005,xcdp006,xcdp007,xcdp010) enable validate;

create unique index xcdp_pk on xcdp_t (xcdpent,xcdpld,xcdp001,xcdp003,xcdp004,xcdp005,xcdp006,xcdp007,xcdp010);

grant select on xcdp_t to tiptop;
grant update on xcdp_t to tiptop;
grant delete on xcdp_t to tiptop;
grant insert on xcdp_t to tiptop;

exit;
