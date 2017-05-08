/* 
================================================================================
檔案代號:prfd_t
檔案名稱:客戶組資料明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prfd_t
(
prfdent       number(5)      ,/* 企業編號 */
prfdsite       varchar2(10)      ,/* 營運據點 */
prfd001       varchar2(10)      ,/* 客戶組編號 */
prfd002       number(10,0)      ,/* 組別 */
prfd003       varchar2(10)      ,/* 屬性 */
prfd004       varchar2(20)      ,/* 屬性編號 */
prfdstus       varchar2(10)      ,/* 狀態碼 */
prfdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prfdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prfdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prfdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prfdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prfdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prfdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prfdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prfdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prfdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prfdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prfdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prfdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prfdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prfdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prfdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prfdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prfdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prfdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prfdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prfdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prfdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prfdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prfdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prfdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prfdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prfdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prfdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prfdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prfdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prfd_t add constraint prfd_pk primary key (prfdent,prfd001,prfd002,prfd003,prfd004) enable validate;

create unique index prfd_pk on prfd_t (prfdent,prfd001,prfd002,prfd003,prfd004);

grant select on prfd_t to tiptop;
grant update on prfd_t to tiptop;
grant delete on prfd_t to tiptop;
grant insert on prfd_t to tiptop;

exit;
