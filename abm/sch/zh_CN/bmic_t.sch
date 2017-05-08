/* 
================================================================================
檔案代號:bmic_t
檔案名稱:料件承認申請成份與物質檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmic_t
(
bmicent       number(5)      ,/* 企業編號 */
bmicsite       varchar2(10)      ,/* 營運據點 */
bmicdocno       varchar2(20)      ,/* 料件承認申請單號 */
bmic001       varchar2(10)      ,/* 類型 */
bmic002       varchar2(10)      ,/* 成份/物質 */
bmic003       number(20,6)      ,/* 含量 */
bmic004       varchar2(10)      ,/* 單位 */
bmic005       varchar2(10)      ,/* 管制類型 */
bmicud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmicud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmicud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmicud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmicud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmicud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmicud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmicud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmicud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmicud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmicud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmicud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmicud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmicud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmicud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmicud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmicud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmicud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmicud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmicud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmicud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmicud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmicud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmicud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmicud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmicud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmicud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmicud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmicud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmicud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmic_t add constraint bmic_pk primary key (bmicent,bmicdocno,bmic001,bmic002) enable validate;

create unique index bmic_pk on bmic_t (bmicent,bmicdocno,bmic001,bmic002);

grant select on bmic_t to tiptop;
grant update on bmic_t to tiptop;
grant delete on bmic_t to tiptop;
grant insert on bmic_t to tiptop;

exit;
