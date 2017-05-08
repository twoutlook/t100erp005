/* 
================================================================================
檔案代號:prce_t
檔案名稱:活動計劃生效組織資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prce_t
(
prceent       number(5)      ,/* 企業編號 */
prceunit       varchar2(10)      ,/* 應用組織 */
prcesite       varchar2(10)      ,/* 營運據點 */
prce001       varchar2(30)      ,/* 活動計劃 */
prce002       varchar2(10)      ,/* 類型 */
prce003       varchar2(10)      ,/* 店群/門店 */
prceacti       varchar2(10)      ,/* 有效否 */
prceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prceud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prce_t add constraint prce_pk primary key (prceent,prce001,prce002,prce003) enable validate;

create unique index prce_pk on prce_t (prceent,prce001,prce002,prce003);

grant select on prce_t to tiptop;
grant update on prce_t to tiptop;
grant delete on prce_t to tiptop;
grant insert on prce_t to tiptop;

exit;
