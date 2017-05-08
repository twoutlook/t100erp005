/* 
================================================================================
檔案代號:apgm_t
檔案名稱:到貨明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apgm_t
(
apgment       number(5)      ,/* 企業編號 */
apgmcomp       varchar2(10)      ,/* 法人 */
apgmdocno       varchar2(20)      ,/* 到貨單號 */
apgmseq       number(10,0)      ,/* 項次 */
apgmseq2       number(10,0)      ,/* 申請單項次 */
apgmorga       varchar2(10)      ,/* 來源組織 */
apgm001       varchar2(20)      ,/* 採購單號 */
apgm002       number(10,0)      ,/* 採購單號項次 */
apgm003       varchar2(40)      ,/* 產品編號 */
apgm004       number(20,6)      ,/* 到貨數量 */
apgm005       number(20,6)      ,/* 原幣含稅單價 */
apgm006       varchar2(10)      ,/* 稅別 */
apgm105       number(20,6)      ,/* 原幣含稅金額 */
apgmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apgmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apgmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apgmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apgmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apgmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apgmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apgmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apgmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apgmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apgmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apgmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apgmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apgmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apgmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apgmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apgmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apgmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apgmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apgmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apgmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apgmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apgmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apgmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apgmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apgmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apgmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apgmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apgmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apgmud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apgm100       varchar2(10)      ,/* 幣別 */
apgm101       number(20,10)      ,/* 匯率 */
apgm115       number(20,6)      /* 本幣含稅金額 */
);
alter table apgm_t add constraint apgm_pk primary key (apgment,apgmcomp,apgmdocno,apgmseq) enable validate;

create unique index apgm_pk on apgm_t (apgment,apgmcomp,apgmdocno,apgmseq);

grant select on apgm_t to tiptop;
grant update on apgm_t to tiptop;
grant delete on apgm_t to tiptop;
grant insert on apgm_t to tiptop;

exit;
