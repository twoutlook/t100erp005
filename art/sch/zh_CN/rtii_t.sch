/* 
================================================================================
檔案代號:rtii_t
檔案名稱:銷售交易換贈返物記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtii_t
(
rtiient       number(5)      ,/* 企業編號 */
rtiisite       varchar2(10)      ,/* 營運據點 */
rtiiunit       varchar2(10)      ,/* 應用組織 */
rtiidocno       varchar2(20)      ,/* 單據編號 */
rtii001       varchar2(10)      ,/* 單據類型 */
rtii002       varchar2(10)      ,/* 促銷類型 */
rtii003       varchar2(20)      ,/* 促銷規則 */
rtii004       number(10,0)      ,/* 條件組別 */
rtii005       number(5,0)      ,/* 達成倍數 */
rtiiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtiiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtiiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtiiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtiiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtiiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtiiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtiiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtiiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtiiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtiiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtiiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtiiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtiiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtiiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtiiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtiiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtiiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtiiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtiiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtiiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtiiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtiiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtiiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtiiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtiiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtiiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtiiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtiiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtiiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtii_t add constraint rtii_pk primary key (rtiient,rtiidocno,rtii003,rtii004) enable validate;

create unique index rtii_pk on rtii_t (rtiient,rtiidocno,rtii003,rtii004);

grant select on rtii_t to tiptop;
grant update on rtii_t to tiptop;
grant delete on rtii_t to tiptop;
grant insert on rtii_t to tiptop;

exit;
