/* 
================================================================================
檔案代號:bxdi_t
檔案名稱:保稅機器設備外送單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bxdi_t
(
bxdient       number(5)      ,/* 企業編號 */
bxdisite       varchar2(10)      ,/* 營運據點 */
bxdidocno       varchar2(20)      ,/* 外送單號 */
bxdiseq       number(10,0)      ,/* 項次 */
bxdi001       varchar2(20)      ,/* 機器設備編號 */
bxdi002       number(10,0)      ,/* 序號 */
bxdi003       number(20,6)      ,/* 外送數量 */
bxdi004       varchar2(80)      ,/* 外送地點 */
bxdi005       date      ,/* 預計收回日 */
bxdi006       number(20,6)      ,/* 已收回數量 */
bxdi007       varchar2(255)      ,/* 備註 */
bxdiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxdi_t add constraint bxdi_pk primary key (bxdient,bxdidocno,bxdiseq) enable validate;

create unique index bxdi_pk on bxdi_t (bxdient,bxdidocno,bxdiseq);

grant select on bxdi_t to tiptop;
grant update on bxdi_t to tiptop;
grant delete on bxdi_t to tiptop;
grant insert on bxdi_t to tiptop;

exit;
