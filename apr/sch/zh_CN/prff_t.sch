/* 
================================================================================
檔案代號:prff_t
檔案名稱:產品價格組申請資料明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prff_t
(
prffent       number(5)      ,/* 企業編號 */
prffunit       varchar2(10)      ,/* 應用組織 */
prffsite       varchar2(10)      ,/* 營運據點 */
prffdocno       varchar2(20)      ,/* 申請單號 */
prff001       number(10,0)      ,/* 組別 */
prff002       varchar2(10)      ,/* 屬性 */
prff003       varchar2(40)      ,/* 屬性代碼 */
prffacti       varchar2(1)      ,/* 有效否 */
prffud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prffud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prffud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prffud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prffud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prffud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prffud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prffud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prffud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prffud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prffud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prffud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prffud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prffud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prffud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prffud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prffud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prffud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prffud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prffud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prffud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prffud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prffud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prffud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prffud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prffud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prffud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prffud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prffud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prffud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prff_t add constraint prff_pk primary key (prffent,prffdocno,prff001,prff002,prff003) enable validate;

create unique index prff_pk on prff_t (prffent,prffdocno,prff001,prff002,prff003);

grant select on prff_t to tiptop;
grant update on prff_t to tiptop;
grant delete on prff_t to tiptop;
grant insert on prff_t to tiptop;

exit;
