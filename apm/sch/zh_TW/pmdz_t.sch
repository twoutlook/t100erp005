/* 
================================================================================
檔案代號:pmdz_t
檔案名稱:採購合約累計定價明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmdz_t
(
pmdzent       number(5)      ,/* 企業編號 */
pmdzsite       varchar2(10)      ,/* 營運據點 */
pmdzdocno       varchar2(20)      ,/* 合約單號 */
pmdzseq       number(10,0)      ,/* 項次 */
pmdzseq1       number(10,0)      ,/* 項序 */
pmdz001       number(20,6)      ,/* 到達數量 */
pmdz002       number(20,6)      ,/* 單價 */
pmdz003       number(20,6)      ,/* 折扣率 */
pmdz004       date      ,/* 數量到達日期 */
pmdz005       varchar2(20)      ,/* 數量到達參考單號 */
pmdzud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdzud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdzud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdzud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdzud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdzud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdzud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdzud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdzud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdzud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdzud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdzud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdzud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdzud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdzud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdzud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdzud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdzud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdzud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdzud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdzud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdzud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdzud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdzud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdzud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdzud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdzud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdzud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdzud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdzud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmdz_t add constraint pmdz_pk primary key (pmdzent,pmdzdocno,pmdzseq,pmdzseq1) enable validate;

create unique index pmdz_pk on pmdz_t (pmdzent,pmdzdocno,pmdzseq,pmdzseq1);

grant select on pmdz_t to tiptop;
grant update on pmdz_t to tiptop;
grant delete on pmdz_t to tiptop;
grant insert on pmdz_t to tiptop;

exit;
