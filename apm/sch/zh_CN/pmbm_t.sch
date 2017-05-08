/* 
================================================================================
檔案代號:pmbm_t
檔案名稱:供應商評核公式定量評核項目檔(製造)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmbm_t
(
pmbment       number(5)      ,/* 企業編號 */
pmbmsite       varchar2(10)      ,/* 營運據點 */
pmbm001       varchar2(10)      ,/* 公式編號 */
pmbm002       varchar2(10)      ,/* 項目編號 */
pmbm003       number(20,6)      ,/* 權重 */
pmbm004       varchar2(10)      ,/* 評分公式 */
pmbm005       number(10,0)      ,/* 交期容許差異天數 */
pmbm006       varchar2(10)      ,/* 目標價格類型 */
pmbmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbm_t add constraint pmbm_pk primary key (pmbment,pmbmsite,pmbm001,pmbm002) enable validate;

create unique index pmbm_pk on pmbm_t (pmbment,pmbmsite,pmbm001,pmbm002);

grant select on pmbm_t to tiptop;
grant update on pmbm_t to tiptop;
grant delete on pmbm_t to tiptop;
grant insert on pmbm_t to tiptop;

exit;
