/* 
================================================================================
檔案代號:sfoc_t
檔案名稱:工單製程變更上站作業資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfoc_t
(
sfocent       number(5)      ,/* 企業代碼 */
sfocsite       varchar2(10)      ,/* 營運據點 */
sfocdocno       varchar2(20)      ,/* 工單單號 */
sfoc001       number(10,0)      ,/* RUN CARD */
sfoc002       number(10,0)      ,/* 項次 */
sfoc003       varchar2(10)      ,/* 上站作業 */
sfoc004       varchar2(10)      ,/* 上站製程序 */
sfoc900       number(5,0)      ,/* 變更序 */
sfoc901       varchar2(1)      ,/* 變更類型 */
sfoc902       date      ,/* 變更日期 */
sfoc905       varchar2(10)      ,/* 變更理由 */
sfoc906       varchar2(255)      ,/* 變更備註 */
sfocseq       number(10,0)      ,/* 項序 */
sfocud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfocud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfocud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfocud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfocud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfocud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfocud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfocud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfocud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfocud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfocud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfocud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfocud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfocud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfocud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfocud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfocud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfocud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfocud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfocud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfocud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfocud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfocud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfocud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfocud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfocud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfocud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfocud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfocud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfocud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfoc_t add constraint sfoc_pk primary key (sfocent,sfocdocno,sfoc001,sfoc002,sfoc003,sfoc004,sfoc900,sfocseq) enable validate;

create unique index sfoc_pk on sfoc_t (sfocent,sfocdocno,sfoc001,sfoc002,sfoc003,sfoc004,sfoc900,sfocseq);

grant select on sfoc_t to tiptop;
grant update on sfoc_t to tiptop;
grant delete on sfoc_t to tiptop;
grant insert on sfoc_t to tiptop;

exit;
