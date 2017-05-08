/* 
================================================================================
檔案代號:pmbz_t
檔案名稱:交易對象准入-經銷商儲運能力
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmbz_t
(
pmbzent       number(5)      ,/* 企業編號 */
pmbzdocno       varchar2(20)      ,/* 單據編號 */
pmbz001       varchar2(10)      ,/* 交易對象編號 */
pmbz002       varchar2(10)      ,/* 車輛類別 */
pmbz003       number(10,0)      ,/* 數量 */
pmbzud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbzud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbzud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbzud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbzud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbzud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbzud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbzud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbzud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbzud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbzud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbzud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbzud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbzud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbzud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbzud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbzud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbzud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbzud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbzud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbzud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbzud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbzud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbzud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbzud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbzud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbzud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbzud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbzud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbzud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbz_t add constraint pmbz_pk primary key (pmbzent,pmbzdocno,pmbz002) enable validate;

create unique index pmbz_pk on pmbz_t (pmbzent,pmbzdocno,pmbz002);

grant select on pmbz_t to tiptop;
grant update on pmbz_t to tiptop;
grant delete on pmbz_t to tiptop;
grant insert on pmbz_t to tiptop;

exit;
