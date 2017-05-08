/* 
================================================================================
檔案代號:xcfm_t
檔案名稱:在制貨齡數量期初開帳檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcfm_t
(
xcfment       number(5)      ,/* 企業編號 */
xcfmcomp       varchar2(10)      ,/* 法人組織 */
xcfmsite       varchar2(10)      ,/* 營運組織 */
xcfm001       varchar2(20)      ,/* 工單號 */
xcfm002       varchar2(40)      ,/* 料件 */
xcfm003       varchar2(256)      ,/* 特性 */
xcfm004       varchar2(10)      ,/* 倉庫 */
xcfm005       varchar2(10)      ,/* 儲位 */
xcfm006       varchar2(30)      ,/* 批號 */
xcfm007       date      ,/* 發料日期 */
xcfm008       varchar2(10)      ,/* 成本單位 */
xcfm009       number(20,6)      ,/* 發料數量 */
xcfmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcfmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcfmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcfmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcfmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcfmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcfmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcfmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcfmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcfmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcfmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcfmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcfmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcfmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcfmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcfmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcfmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcfmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcfmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcfmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcfmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcfmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcfmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcfmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcfmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcfmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcfmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcfmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcfmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcfmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcfm_t add constraint xcfm_pk primary key (xcfment,xcfmsite,xcfm001,xcfm002,xcfm003,xcfm004,xcfm005,xcfm006,xcfm007) enable validate;

create unique index xcfm_pk on xcfm_t (xcfment,xcfmsite,xcfm001,xcfm002,xcfm003,xcfm004,xcfm005,xcfm006,xcfm007);

grant select on xcfm_t to tiptop;
grant update on xcfm_t to tiptop;
grant delete on xcfm_t to tiptop;
grant insert on xcfm_t to tiptop;

exit;
