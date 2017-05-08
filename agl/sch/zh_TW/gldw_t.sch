/* 
================================================================================
檔案代號:gldw_t
檔案名稱:合併報表會計科目沖銷規則_MULTI科目核算項值設定資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gldw_t
(
gldwent       number(5)      ,/* 企業代碼 */
gldw001       varchar2(10)      ,/* 公司編號(來源) */
gldw002       varchar2(5)      ,/* 合併帳別(來源) */
gldw003       varchar2(10)      ,/* 公司編號(對沖) */
gldw004       varchar2(5)      ,/* 合併帳別(對沖) */
gldw005       varchar2(10)      ,/* 上層公司(合併主體) */
gldw006       varchar2(5)      ,/* 合併帳別(合併主體) */
gldw007       number(10,0)      ,/* 沖銷組別序號 */
gldw008       varchar2(1)      ,/* 來源/對沖 */
gldw009       varchar2(24)      ,/* MULTI代號 */
gldw010       varchar2(24)      ,/* 科目編號 */
gldw011       varchar2(30)      ,/* 核算項值 */
gldwownid       varchar2(20)      ,/* 資料所有者 */
gldwowndp       varchar2(10)      ,/* 資料所屬部門 */
gldwcrtid       varchar2(20)      ,/* 資料建立者 */
gldwcrtdp       varchar2(10)      ,/* 資料建立部門 */
gldwcrtdt       timestamp(0)      ,/* 資料創建日 */
gldwmodid       varchar2(20)      ,/* 資料修改者 */
gldwmoddt       timestamp(0)      ,/* 最近修改日 */
gldwstus       varchar2(10)      ,/* 狀態碼 */
gldwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldw_t add constraint gldw_pk primary key (gldwent,gldw001,gldw002,gldw003,gldw004,gldw005,gldw006,gldw007,gldw008,gldw009,gldw010,gldw011) enable validate;

create unique index gldw_pk on gldw_t (gldwent,gldw001,gldw002,gldw003,gldw004,gldw005,gldw006,gldw007,gldw008,gldw009,gldw010,gldw011);

grant select on gldw_t to tiptop;
grant update on gldw_t to tiptop;
grant delete on gldw_t to tiptop;
grant insert on gldw_t to tiptop;

exit;
