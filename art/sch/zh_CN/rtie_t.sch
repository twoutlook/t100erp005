/* 
================================================================================
檔案代號:rtie_t
檔案名稱:銷售交易收款檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtie_t
(
rtieent       number(5)      ,/* 企業編號 */
rtiesite       varchar2(10)      ,/* 營運據點 */
rtieunit       varchar2(10)      ,/* 應用組織 */
rtiedocno       varchar2(20)      ,/* 單據編號 */
rtieseq       number(10,0)      ,/* 項次 */
rtieseq1       number(10,0)      ,/* 收款序 */
rtie001       varchar2(10)      ,/* 款別類型 */
rtie002       varchar2(10)      ,/* 款別編號 */
rtie003       number(20,6)      ,/* 收款金額 */
rtie004       number(20,6)      ,/* 票券溢收款金額 */
rtie005       number(20,6)      ,/* 找零金額 */
rtie006       number(20,6)      ,/* 實收金額 */
rtie007       number(15,3)      ,/* 抵現積分 */
rtieud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtieud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtieud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtieud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtieud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtieud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtieud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtieud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtieud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtieud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtieud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtieud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtieud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtieud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtieud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtieud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtieud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtieud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtieud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtieud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtieud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtieud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtieud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtieud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtieud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtieud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtieud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtieud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtieud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtieud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtie_t add constraint rtie_pk primary key (rtieent,rtiedocno,rtieseq,rtieseq1) enable validate;

create unique index rtie_pk on rtie_t (rtieent,rtiedocno,rtieseq,rtieseq1);

grant select on rtie_t to tiptop;
grant update on rtie_t to tiptop;
grant delete on rtie_t to tiptop;
grant insert on rtie_t to tiptop;

exit;
