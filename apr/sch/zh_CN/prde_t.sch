/* 
================================================================================
檔案代號:prde_t
檔案名稱:促銷規則申請生效組織資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prde_t
(
prdeent       number(5)      ,/* 企業編號 */
prdeunit       varchar2(10)      ,/* 應用組織 */
prdesite       varchar2(10)      ,/* 營運據點 */
prdedocno       varchar2(20)      ,/* 促銷申請單號 */
prde001       varchar2(20)      ,/* 規則編號 */
prde002       number(10,0)      ,/* 組別 */
prde003       varchar2(10)      ,/* 類型 */
prde004       varchar2(10)      ,/* 店群/門店 */
prdeacti       varchar2(10)      ,/* 有效否 */
prdeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prde_t add constraint prde_pk primary key (prdeent,prdedocno,prde002) enable validate;

create unique index prde_pk on prde_t (prdeent,prdedocno,prde002);

grant select on prde_t to tiptop;
grant update on prde_t to tiptop;
grant delete on prde_t to tiptop;
grant insert on prde_t to tiptop;

exit;
