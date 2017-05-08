/* 
================================================================================
檔案代號:xcdx_t
檔案名稱:工藝在製成本次要素本期調整檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcdx_t
(
xcdxent       number(5)      ,/* 企業編號 */
xcdxld       varchar2(5)      ,/* 帳套 */
xcdxcomp       varchar2(10)      ,/* 法人組織 */
xcdx001       varchar2(1)      ,/* 帳套本位幣順序 */
xcdx002       varchar2(30)      ,/* 成本域 */
xcdx003       varchar2(10)      ,/* 成本計算類型 */
xcdx004       number(5,0)      ,/* 年度 */
xcdx005       number(5,0)      ,/* 期別 */
xcdx006       varchar2(20)      ,/* 調整單號 */
xcdx007       varchar2(20)      ,/* 工單編號 */
xcdx008       varchar2(10)      ,/* 作業編號 */
xcdx009       varchar2(1)      ,/* 作業序 */
xcdx010       varchar2(10)      ,/* 次要素 */
xcdx011       varchar2(1)      ,/* 調整類型 */
xcdx012       varchar2(80)      ,/* 調整說明 */
xcdx101       number(20,6)      ,/* 當月調整數量 */
xcdx102       number(20,6)      ,/* 當月調整金額 */
xcdxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcdxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcdxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcdxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcdxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcdxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcdxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcdxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcdxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcdxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcdxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcdxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcdxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcdxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcdxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcdxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcdxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcdxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcdxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcdxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcdxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcdxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcdxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcdxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcdxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcdxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcdxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcdxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcdxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcdxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcdx_t add constraint xcdx_pk primary key (xcdxent,xcdxld,xcdx001,xcdx002,xcdx003,xcdx004,xcdx005,xcdx006,xcdx007,xcdx008,xcdx009,xcdx010) enable validate;

create unique index xcdx_pk on xcdx_t (xcdxent,xcdxld,xcdx001,xcdx002,xcdx003,xcdx004,xcdx005,xcdx006,xcdx007,xcdx008,xcdx009,xcdx010);

grant select on xcdx_t to tiptop;
grant update on xcdx_t to tiptop;
grant delete on xcdx_t to tiptop;
grant insert on xcdx_t to tiptop;

exit;
