/* 
================================================================================
檔案代號:stii_t
檔案名稱:招商租賃合約申請定義帳期單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stii_t
(
stiient       number(5)      ,/* 企業編號 */
stiisite       varchar2(10)      ,/* 營運組織 */
stiiunit       varchar2(10)      ,/* 制定組織 */
stiidocno       varchar2(20)      ,/* 單據編號 */
stiiseq       number(10,0)      ,/* 項次 */
stii001       varchar2(20)      ,/* 合約編號 */
stii002       varchar2(10)      ,/* 費用編號 */
stii003       varchar2(10)      ,/* 結算方式 */
stii004       number(5,0)      ,/* 岀帳期 */
stii005       number(5,0)      ,/* 岀帳日 */
stii006       varchar2(10)      ,/* 核算制度 */
stii007       varchar2(1)      ,/* 納入結算單否 */
stii008       varchar2(1)      ,/* 票扣否 */
stiiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stiiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stiiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stiiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stiiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stiiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stiiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stiiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stiiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stiiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stiiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stiiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stiiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stiiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stiiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stiiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stiiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stiiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stiiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stiiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stiiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stiiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stiiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stiiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stiiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stiiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stiiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stiiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stiiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stiiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stii009       varchar2(1)      ,/* 類型 */
stii010       varchar2(10)      /* 稅別 */
);
alter table stii_t add constraint stii_pk primary key (stiient,stiidocno,stiiseq) enable validate;

create unique index stii_pk on stii_t (stiient,stiidocno,stiiseq);

grant select on stii_t to tiptop;
grant update on stii_t to tiptop;
grant delete on stii_t to tiptop;
grant insert on stii_t to tiptop;

exit;
