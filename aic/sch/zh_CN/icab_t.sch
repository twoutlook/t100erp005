/* 
================================================================================
檔案代號:icab_t
檔案名稱:多角貿易營運據點檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table icab_t
(
icabent       number(5)      ,/* 企業編號 */
icabsite       varchar2(10)      ,/* 營運據點 */
icab001       varchar2(10)      ,/* 流程代碼 */
icab002       number(5,0)      ,/* 站別 */
icab003       varchar2(10)      ,/* 營運據點 */
icab004       varchar2(1)      ,/* 委外工單開立點 */
icab005       varchar2(1)      ,/* 中斷點否 */
icab006       varchar2(10)      ,/* 營業額申報方式 */
icab007       varchar2(10)      ,/* 計價幣別 */
icab008       varchar2(1)      ,/* 實體庫存否 */
icabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
icabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
icabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
icabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
icabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
icabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
icabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
icabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
icabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
icabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
icabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
icabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
icabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
icabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
icabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
icabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
icabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
icabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
icabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
icabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
icabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
icabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
icabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
icabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
icabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
icabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
icabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
icabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
icabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
icabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table icab_t add constraint icab_pk primary key (icabent,icab001,icab002) enable validate;

create unique index icab_pk on icab_t (icabent,icab001,icab002);

grant select on icab_t to tiptop;
grant update on icab_t to tiptop;
grant delete on icab_t to tiptop;
grant insert on icab_t to tiptop;

exit;
