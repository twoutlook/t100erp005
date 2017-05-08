/* 
================================================================================
檔案代號:deas_t
檔案名稱:收銀差錯處理資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table deas_t
(
deasent       number(5)      ,/* 企業編號 */
deasdocno       varchar2(20)      ,/* 繳款單號 */
deasseq       number(10,0)      ,/* 項次 */
deasseq1       number(10,0)      ,/* 序 */
deas001       varchar2(10)      ,/* 差錯處理方式 */
deas002       number(20,6)      ,/* 處理金額 */
deas003       varchar2(10)      ,/* 處理單據類型 */
deas004       varchar2(20)      ,/* 處理單據編號 */
deas005       varchar2(10)      ,/* 歸責對象 */
deas006       varchar2(255)      ,/* 備註 */
deasud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deasud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deasud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deasud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deasud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deasud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deasud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deasud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deasud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deasud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deasud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deasud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deasud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deasud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deasud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deasud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deasud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deasud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deasud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deasud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deasud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deasud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deasud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deasud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deasud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deasud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deasud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deasud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deasud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deasud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deas_t add constraint deas_pk primary key (deasent,deasdocno,deasseq,deasseq1) enable validate;

create unique index deas_pk on deas_t (deasent,deasdocno,deasseq,deasseq1);

grant select on deas_t to tiptop;
grant update on deas_t to tiptop;
grant delete on deas_t to tiptop;
grant insert on deas_t to tiptop;

exit;
