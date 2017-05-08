/* 
================================================================================
檔案代號:prdc_t
檔案名稱:促銷規則申請對象明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdc_t
(
prdcent       number(5)      ,/* 企業編號 */
prdcunit       varchar2(10)      ,/* 應用組織 */
prdcsite       varchar2(10)      ,/* 營運據點 */
prdcdocno       varchar2(20)      ,/* 促銷申請單號 */
prdc001       varchar2(20)      ,/* 規則編號 */
prdc002       number(10,0)      ,/* 組別 */
prdc003       varchar2(10)      ,/* 對象屬性 */
prdc004       varchar2(10)      ,/* 屬性代碼 */
prdcacti       varchar2(10)      ,/* 有效否 */
prdcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prdc_t add constraint prdc_pk primary key (prdcent,prdcdocno,prdc002,prdc003,prdc004) enable validate;

create unique index prdc_pk on prdc_t (prdcent,prdcdocno,prdc002,prdc003,prdc004);

grant select on prdc_t to tiptop;
grant update on prdc_t to tiptop;
grant delete on prdc_t to tiptop;
grant insert on prdc_t to tiptop;

exit;
