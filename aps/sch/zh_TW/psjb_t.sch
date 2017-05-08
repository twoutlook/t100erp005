/* 
================================================================================
檔案代號:psjb_t
檔案名稱:採購預測策略期別檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psjb_t
(
psjbent       number(5)      ,/* 企業編號 */
psjbsite       varchar2(10)      ,/* 營運據點 */
psjb001       varchar2(10)      ,/* 預測編號 */
psjb002       number(5,0)      ,/* 期別 */
psjb003       varchar2(10)      ,/* 週期 */
psjbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psjbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psjbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psjbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psjbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psjbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psjbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psjbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psjbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psjbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psjbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psjbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psjbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psjbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psjbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psjbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psjbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psjbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psjbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psjbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psjbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psjbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psjbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psjbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psjbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psjbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psjbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psjbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psjbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psjbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psjb_t add constraint psjb_pk primary key (psjbent,psjbsite,psjb001,psjb002) enable validate;

create unique index psjb_pk on psjb_t (psjbent,psjbsite,psjb001,psjb002);

grant select on psjb_t to tiptop;
grant update on psjb_t to tiptop;
grant delete on psjb_t to tiptop;
grant insert on psjb_t to tiptop;

exit;
