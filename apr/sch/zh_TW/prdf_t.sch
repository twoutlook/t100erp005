/* 
================================================================================
檔案代號:prdf_t
檔案名稱:促銷規則申請款別限定資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdf_t
(
prdfent       number(5)      ,/* 企業編號 */
prdfunit       varchar2(10)      ,/* 應用組織 */
prdfsite       varchar2(10)      ,/* 營運據點 */
prdfdocno       varchar2(20)      ,/* 促銷申請單號 */
prdf001       varchar2(20)      ,/* 規則編號 */
prdf002       number(10,0)      ,/* 組別 */
prdf003       varchar2(10)      ,/* 款別編號 */
prdf004       varchar2(10)      ,/* 款別子類型 */
prdfacti       varchar2(10)      ,/* 有效否 */
prdfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prdf_t add constraint prdf_pk primary key (prdfent,prdfdocno,prdf002) enable validate;

create unique index prdf_pk on prdf_t (prdfent,prdfdocno,prdf002);

grant select on prdf_t to tiptop;
grant update on prdf_t to tiptop;
grant delete on prdf_t to tiptop;
grant insert on prdf_t to tiptop;

exit;
