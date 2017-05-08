/* 
================================================================================
檔案代號:prfj_t
檔案名稱:客戶定價產品價格組資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prfj_t
(
prfjent       number(5)      ,/* 企業編號 */
prfjunit       varchar2(10)      ,/* 應用組織 */
prfjsite       varchar2(10)      ,/* 營運據點 */
prfjdocno       varchar2(20)      ,/* 申請單號 */
prfjseq       number(10,0)      ,/* 項次 */
prfj001       varchar2(10)      ,/* 產品價格組編號 */
prfjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prfjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prfjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prfjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prfjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prfjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prfjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prfjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prfjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prfjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prfjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prfjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prfjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prfjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prfjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prfjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prfjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prfjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prfjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prfjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prfjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prfjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prfjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prfjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prfjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prfjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prfjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prfjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prfjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prfjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prfj_t add constraint prfj_pk primary key (prfjent,prfjdocno,prfjseq) enable validate;

create unique index prfj_pk on prfj_t (prfjent,prfjdocno,prfjseq);

grant select on prfj_t to tiptop;
grant update on prfj_t to tiptop;
grant delete on prfj_t to tiptop;
grant insert on prfj_t to tiptop;

exit;
