/* 
================================================================================
檔案代號:prfm_t
檔案名稱:客戶產品價格資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table prfm_t
(
prfment       number(5)      ,/* 企業編號 */
prfmunit       varchar2(10)      ,/* 應用組織 */
prfmsite       varchar2(10)      ,/* 營運據點 */
prfm001       varchar2(10)      ,/* 客戶類型 */
prfm002       varchar2(10)      ,/* 客戶編號/客戶組編號 */
prfm003       varchar2(40)      ,/* 產品編號 */
prfm004       varchar2(10)      ,/* 價格類型 */
prfm005       varchar2(10)      ,/* 幣別 */
prfm006       varchar2(10)      ,/* 稅別 */
prfm007       date      ,/* 生效日期 */
prfm008       date      ,/* 失效日期 */
prfm009       varchar2(10)      ,/* 計價單位 */
prfm010       number(20,6)      ,/* 成本價 */
prfm011       number(20,6)      ,/* 出廠價 */
prfm012       number(20,6)      ,/* 毛利率 */
prfm013       number(20,6)      ,/* 批發價 */
prfm014       number(20,6)      ,/* 市場價 */
prfm015       number(20,6)      ,/* 常規配贈 */
prfm016       number(20,6)      ,/* 導購提成 */
prfm017       varchar2(20)      ,/* 來源單號 */
prfm018       number(10,0)      ,/* 來源項次 */
prfmstus       varchar2(10)      ,/* 狀態碼 */
prfm019       timestamp(0)      ,/* 定價日期 */
prfm020       varchar2(40)      ,/* 產品條碼 */
prfmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prfmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prfmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prfmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prfmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prfmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prfmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prfmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prfmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prfmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prfmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prfmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prfmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prfmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prfmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prfmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prfmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prfmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prfmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prfmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prfmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prfmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prfmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prfmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prfmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prfmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prfmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prfmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prfmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prfmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prfm_t add constraint prfm_pk primary key (prfment,prfmsite,prfm001,prfm002,prfm003,prfm004,prfm005,prfm006,prfm007,prfm008,prfm009) enable validate;

create unique index prfm_pk on prfm_t (prfment,prfmsite,prfm001,prfm002,prfm003,prfm004,prfm005,prfm006,prfm007,prfm008,prfm009);

grant select on prfm_t to tiptop;
grant update on prfm_t to tiptop;
grant delete on prfm_t to tiptop;
grant insert on prfm_t to tiptop;

exit;
