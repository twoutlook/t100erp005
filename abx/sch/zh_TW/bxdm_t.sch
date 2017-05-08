/* 
================================================================================
檔案代號:bxdm_t
檔案名稱:保稅機器設備報廢/除帳單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bxdm_t
(
bxdment       number(5)      ,/* 企業編號 */
bxdmsite       varchar2(10)      ,/* 營運據點 */
bxdmdocno       varchar2(20)      ,/* 報廢/除帳單號 */
bxdmseq       number(10,0)      ,/* 項次 */
bxdm001       varchar2(20)      ,/* 機器裝置編號 */
bxdm002       number(10,0)      ,/* 序號 */
bxdm003       number(20,6)      ,/* 報廢/除帳數量 */
bxdm004       varchar2(255)      ,/* 備註 */
bxdmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxdm_t add constraint bxdm_pk primary key (bxdment,bxdmdocno,bxdmseq) enable validate;

create unique index bxdm_pk on bxdm_t (bxdment,bxdmdocno,bxdmseq);

grant select on bxdm_t to tiptop;
grant update on bxdm_t to tiptop;
grant delete on bxdm_t to tiptop;
grant insert on bxdm_t to tiptop;

exit;
