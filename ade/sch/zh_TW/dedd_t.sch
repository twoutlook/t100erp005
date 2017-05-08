/* 
================================================================================
檔案代號:dedd_t
檔案名稱:作廢發票缺單維護作業單身
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table dedd_t
(
deddent       number(5)      ,/* 企業編號 */
deddsite       varchar2(10)      ,/* 營運據點 */
deddunit       varchar2(10)      ,/* 應用組織 */
dedddocno       varchar2(20)      ,/* 單據編號 */
deddseq       number(10,0)      ,/* 項次 */
dedddocdt       date      ,/* 營業日期 */
dedd001       varchar2(10)      ,/* 專櫃編號 */
dedd002       varchar2(10)      ,/* 收銀機編號 */
dedd003       varchar2(20)      ,/* 交易序號 */
dedd004       varchar2(20)      ,/* 起始發票號 */
dedd005       varchar2(20)      ,/* 截止發票號 */
dedd006       number(20,6)      ,/* 發票金額 */
dedd007       varchar2(80)      ,/* 備註 */
deddud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deddud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deddud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deddud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deddud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deddud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deddud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deddud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deddud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deddud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deddud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deddud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deddud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deddud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deddud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deddud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deddud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deddud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deddud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deddud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deddud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deddud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deddud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deddud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deddud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deddud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deddud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deddud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deddud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deddud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dedd_t add constraint dedd_pk primary key (deddent,dedddocno,deddseq) enable validate;

create unique index dedd_pk on dedd_t (deddent,dedddocno,deddseq);

grant select on dedd_t to tiptop;
grant update on dedd_t to tiptop;
grant delete on dedd_t to tiptop;
grant insert on dedd_t to tiptop;

exit;
