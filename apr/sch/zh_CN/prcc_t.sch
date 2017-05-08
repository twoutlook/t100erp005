/* 
================================================================================
檔案代號:prcc_t
檔案名稱:促銷活動計劃申請生效組織資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prcc_t
(
prccent       number(5)      ,/* 企業編號 */
prccunit       varchar2(10)      ,/* 應用組織 */
prccsite       varchar2(10)      ,/* 營運據點 */
prccdocno       varchar2(20)      ,/* 申請單號 */
prccseq       number(10,0)      ,/* 活動計劃項次 */
prcc001       varchar2(10)      ,/* 類型 */
prcc002       varchar2(10)      ,/* 店群/門店 */
prccacti       varchar2(10)      ,/* 有效否 */
prccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prcc_t add constraint prcc_pk primary key (prccent,prccdocno,prccseq,prcc001,prcc002) enable validate;

create unique index prcc_pk on prcc_t (prccent,prccdocno,prccseq,prcc001,prcc002);

grant select on prcc_t to tiptop;
grant update on prcc_t to tiptop;
grant delete on prcc_t to tiptop;
grant insert on prcc_t to tiptop;

exit;
