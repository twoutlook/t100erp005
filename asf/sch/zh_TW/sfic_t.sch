/* 
================================================================================
檔案代號:sfic_t
檔案名稱:重工轉出製程上站作業資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfic_t
(
sficent       number(5)      ,/* 企業編號 */
sficsite       varchar2(10)      ,/* 營運據點 */
sficdocno       varchar2(20)      ,/* 重工轉出單號 */
sficseq       number(10,0)      ,/* 項次 */
sfic001       varchar2(10)      ,/* 上站作業 */
sfic002       varchar2(10)      ,/* 上站作序 */
sficud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sficud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sficud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sficud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sficud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sficud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sficud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sficud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sficud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sficud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sficud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sficud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sficud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sficud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sficud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sficud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sficud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sficud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sficud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sficud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sficud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sficud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sficud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sficud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sficud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sficud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sficud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sficud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sficud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sficud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfic_t add constraint sfic_pk primary key (sficent,sficdocno,sficseq,sfic001,sfic002) enable validate;

create unique index sfic_pk on sfic_t (sficent,sficdocno,sficseq,sfic001,sfic002);

grant select on sfic_t to tiptop;
grant update on sfic_t to tiptop;
grant delete on sfic_t to tiptop;
grant insert on sfic_t to tiptop;

exit;
