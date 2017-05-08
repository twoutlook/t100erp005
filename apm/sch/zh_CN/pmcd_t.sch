/* 
================================================================================
檔案代號:pmcd_t
檔案名稱:供應商評核定量項目設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmcd_t
(
pmcdent       number(5)      ,/* 企業編號 */
pmcd001       varchar2(10)      ,/* 評核期別 */
pmcd002       varchar2(10)      ,/* 評核品類 */
pmcd003       varchar2(10)      ,/* 評核項目 */
pmcd004       number(20,6)      ,/* 權重 */
pmcdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmcdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmcdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmcdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmcdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmcdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmcdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmcdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmcdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmcdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmcdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmcdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmcdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmcdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmcdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmcdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmcdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmcdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmcdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmcdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmcdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmcdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmcdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmcdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmcdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmcdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmcdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmcdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmcdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmcdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmcd_t add constraint pmcd_pk primary key (pmcdent,pmcd001,pmcd002,pmcd003) enable validate;

create unique index pmcd_pk on pmcd_t (pmcdent,pmcd001,pmcd002,pmcd003);

grant select on pmcd_t to tiptop;
grant update on pmcd_t to tiptop;
grant delete on pmcd_t to tiptop;
grant insert on pmcd_t to tiptop;

exit;
