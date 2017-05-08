/* 
================================================================================
檔案代號:fmmt_t
檔案名稱:計提投資收益維護單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmmt_t
(
fmmtent       number(5)      ,/* 企業代碼 */
fmmtdocno       varchar2(20)      ,/* 計息單號 */
fmmtseq       number(10,0)      ,/* 項次 */
fmmt001       varchar2(10)      ,/* 投資組織 */
fmmt002       varchar2(20)      ,/* 投資單號 */
fmmt003       varchar2(10)      ,/* 幣別 */
fmmt004       number(20,6)      ,/* 本金 */
fmmt005       date      ,/* 起算日期 */
fmmt006       date      ,/* 止算日期 */
fmmt007       number(5,0)      ,/* 天數 */
fmmt008       number(10,6)      ,/* 年利率 */
fmmt009       varchar2(1)      ,/* 計息方式 */
fmmt010       number(20,6)      ,/* 本期計提金額 */
fmmtud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmtud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmtud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmtud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmtud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmtud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmtud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmtud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmtud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmtud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmtud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmtud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmtud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmtud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmtud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmtud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmtud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmtud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmtud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmtud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmtud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmtud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmtud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmtud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmtud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmtud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmtud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmtud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmtud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmtud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmmt011       number(20,6)      ,/* 利息調整 */
fmmt012       number(20,6)      ,/* 投資收益 */
fmmt013       number(20,10)      ,/* 匯率 */
fmmt014       number(20,6)      ,/* 計提本幣金額 */
fmmt015       number(20,6)      ,/* 本幣利息調整 */
fmmt016       number(20,6)      ,/* 本幣投資收益 */
fmmt017       varchar2(10)      ,/* 計息來源 */
fmmt018       number(20,6)      ,/* 已收原幣金額 */
fmmt019       number(20,6)      /* 已收本幣金額 */
);
alter table fmmt_t add constraint fmmt_pk primary key (fmmtent,fmmtdocno,fmmtseq) enable validate;

create unique index fmmt_pk on fmmt_t (fmmtent,fmmtdocno,fmmtseq);

grant select on fmmt_t to tiptop;
grant update on fmmt_t to tiptop;
grant delete on fmmt_t to tiptop;
grant insert on fmmt_t to tiptop;

exit;
