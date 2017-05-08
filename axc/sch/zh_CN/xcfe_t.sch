/* 
================================================================================
檔案代號:xcfe_t
檔案名稱:LCM料件市价分类设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcfe_t
(
xcfeent       number(5)      ,/* 企业编号 */
xcfecomp       varchar2(10)      ,/* 法人组织 */
xcfe001       number(5,0)      ,/* 年度 */
xcfe002       number(5,0)      ,/* 期别 */
xcfe003       number(5)      ,/* 料件分类来源 */
xcfe004       varchar2(40)      ,/* 分类码 */
xcfe005       varchar2(10)      ,/* 币种 */
xcfe006       number(20,6)      ,/* 市价 */
xcfeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcfeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcfeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcfeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcfeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcfeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcfeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcfeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcfeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcfeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcfeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcfeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcfeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcfeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcfeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcfeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcfeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcfeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcfeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcfeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcfeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcfeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcfeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcfeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcfeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcfeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcfeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcfeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcfeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcfeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xcfeld       varchar2(5)      /* 账套 */
);
alter table xcfe_t add constraint xcfe_pk primary key (xcfeent,xcfecomp,xcfe001,xcfe002,xcfe003,xcfe004,xcfeld) enable validate;

create unique index xcfe_pk on xcfe_t (xcfeent,xcfecomp,xcfe001,xcfe002,xcfe003,xcfe004,xcfeld);

grant select on xcfe_t to tiptop;
grant update on xcfe_t to tiptop;
grant delete on xcfe_t to tiptop;
grant insert on xcfe_t to tiptop;

exit;
