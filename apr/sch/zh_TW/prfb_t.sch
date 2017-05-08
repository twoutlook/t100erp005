/* 
================================================================================
檔案代號:prfb_t
檔案名稱:客戶組申請資料明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prfb_t
(
prfbent       number(5)      ,/* 企業編號 */
prfbunit       varchar2(10)      ,/* 應用組織 */
prfbsite       varchar2(10)      ,/* 營運據點 */
prfbdocno       varchar2(20)      ,/* 申請單號 */
prfb001       number(10,0)      ,/* 組別 */
prfb002       varchar2(10)      ,/* 屬性 */
prfb003       varchar2(20)      ,/* 屬性編號 */
prfbacti       varchar2(1)      ,/* 有效否 */
prfbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prfbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prfbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prfbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prfbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prfbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prfbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prfbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prfbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prfbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prfbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prfbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prfbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prfbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prfbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prfbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prfbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prfbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prfbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prfbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prfbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prfbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prfbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prfbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prfbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prfbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prfbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prfbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prfbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prfbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prfb_t add constraint prfb_pk primary key (prfbent,prfbdocno,prfb001,prfb002,prfb003) enable validate;

create unique index prfb_pk on prfb_t (prfbent,prfbdocno,prfb001,prfb002,prfb003);

grant select on prfb_t to tiptop;
grant update on prfb_t to tiptop;
grant delete on prfb_t to tiptop;
grant insert on prfb_t to tiptop;

exit;
