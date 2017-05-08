/* 
================================================================================
檔案代號:xmbw_t
檔案名稱:銷售價格表申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmbw_t
(
xmbwent       number(5)      ,/* 企業編號 */
xmbwdocno       varchar2(20)      ,/* 申請單號 */
xmbw010       varchar2(10)      ,/* 變更方式 */
xmbw011       varchar2(40)      ,/* 料件編號 */
xmbw012       varchar2(256)      ,/* 產品特徵 */
xmbw013       varchar2(10)      ,/* 計價單位 */
xmbw014       varchar2(1)      ,/* 參考資料否 */
xmbw015       varchar2(40)      ,/* 參考料號 */
xmbw016       varchar2(256)      ,/* 參考料號產品特徵 */
xmbw017       number(20,6)      ,/* 加金額 */
xmbw018       number(20,6)      ,/* 加百分比 */
xmbw019       number(20,6)      ,/* 標準成本 */
xmbw020       number(20,6)      ,/* 銷售底價 */
xmbw021       number(20,6)      ,/* 業務底價 */
xmbw022       number(20,6)      ,/* 一般售價 */
xmbw023       number(20,6)      ,/* 標準定價 */
xmbwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmbwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmbwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmbwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmbwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmbwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmbwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmbwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmbwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmbwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmbwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmbwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmbwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmbwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmbwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmbwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmbwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmbwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmbwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmbwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmbwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmbwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmbwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmbwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmbwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmbwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmbwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmbwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmbwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmbwud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmbw031       varchar2(10)      ,/* 系列 */
xmbw032       varchar2(10)      ,/* 產品分類 */
xmbw033       varchar2(10)      ,/* 參考系列 */
xmbw034       varchar2(10)      /* 參考產品分類 */
);
alter table xmbw_t add constraint xmbw_pk primary key (xmbwent,xmbwdocno,xmbw011,xmbw012,xmbw013,xmbw031,xmbw032) enable validate;

create unique index xmbw_pk on xmbw_t (xmbwent,xmbwdocno,xmbw011,xmbw012,xmbw013,xmbw031,xmbw032);

grant select on xmbw_t to tiptop;
grant update on xmbw_t to tiptop;
grant delete on xmbw_t to tiptop;
grant insert on xmbw_t to tiptop;

exit;
