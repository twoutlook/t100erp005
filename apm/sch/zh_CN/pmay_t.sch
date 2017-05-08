/* 
================================================================================
檔案代號:pmay_t
檔案名稱:經銷商市場能力檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmay_t
(
pmayent       number(5)      ,/* 企業編號 */
pmay001       varchar2(10)      ,/* 交易對象編號 */
pmay002       varchar2(10)      ,/* 終端渠道類別 */
pmay003       varchar2(10)      ,/* 終端渠道編號 */
pmay004       number(10,0)      ,/* 渠道崗位經理人數 */
pmay005       number(10,0)      ,/* 覆蓋終端店數 */
pmayud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmayud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmayud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmayud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmayud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmayud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmayud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmayud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmayud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmayud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmayud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmayud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmayud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmayud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmayud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmayud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmayud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmayud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmayud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmayud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmayud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmayud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmayud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmayud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmayud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmayud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmayud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmayud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmayud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmayud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmay_t add constraint pmay_pk primary key (pmayent,pmay001,pmay002,pmay003) enable validate;

create unique index pmay_pk on pmay_t (pmayent,pmay001,pmay002,pmay003);

grant select on pmay_t to tiptop;
grant update on pmay_t to tiptop;
grant delete on pmay_t to tiptop;
grant insert on pmay_t to tiptop;

exit;
