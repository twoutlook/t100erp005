/* 
================================================================================
檔案代號:gldc_t
檔案名稱:合併組織結構單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gldc_t
(
gldcent       number(5)      ,/* 企業代碼 */
gldcld       varchar2(5)      ,/* 合併帳別 */
gldc001       varchar2(10)      ,/* 上層公司 */
gldc002       varchar2(10)      ,/* 下層公司 */
gldc003       varchar2(5)      ,/* 下層公司帳別/合併帳別 */
gldc004       number(20,6)      ,/* 持股比率% */
gldc005       varchar2(1)      ,/* 納入合併否 */
gldc006       number(10,0)      ,/* 投資股數 */
gldc007       number(20,6)      ,/* 股本 */
gldc008       date      ,/* 異動日期 */
gldc009       varchar2(1)      ,/* 上層公司記錄 */
gldcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldc_t add constraint gldc_pk primary key (gldcent,gldcld,gldc001,gldc002,gldc003) enable validate;

create unique index gldc_pk on gldc_t (gldcent,gldcld,gldc001,gldc002,gldc003);

grant select on gldc_t to tiptop;
grant update on gldc_t to tiptop;
grant delete on gldc_t to tiptop;
grant insert on gldc_t to tiptop;

exit;
