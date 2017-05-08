/* 
================================================================================
檔案代號:pmcf_t
檔案名稱:供應商評核績效分級標準設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmcf_t
(
pmcfent       number(5)      ,/* 企業編號 */
pmcf001       varchar2(10)      ,/* 評核期別 */
pmcf002       varchar2(10)      ,/* 評核品類 */
pmcf003       varchar2(10)      ,/* 供應商分級 */
pmcf004       number(15,3)      ,/* 分數起 */
pmcf005       number(15,3)      ,/* 分數迄 */
pmcf006       varchar2(10)      ,/* 處理建議 */
pmcfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmcfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmcfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmcfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmcfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmcfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmcfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmcfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmcfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmcfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmcfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmcfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmcfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmcfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmcfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmcfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmcfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmcfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmcfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmcfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmcfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmcfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmcfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmcfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmcfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmcfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmcfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmcfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmcfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmcfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmcf_t add constraint pmcf_pk primary key (pmcfent,pmcf001,pmcf002,pmcf003) enable validate;

create unique index pmcf_pk on pmcf_t (pmcfent,pmcf001,pmcf002,pmcf003);

grant select on pmcf_t to tiptop;
grant update on pmcf_t to tiptop;
grant delete on pmcf_t to tiptop;
grant insert on pmcf_t to tiptop;

exit;
