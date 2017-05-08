/* 
================================================================================
檔案代號:rtbf_t
檔案名稱:商品轉類單庫存明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtbf_t
(
rtbfent       number(5)      ,/* 企業代碼 */
rtbfsite       varchar2(10)      ,/* 營運據點 */
rtbfdocno       varchar2(20)      ,/* 單據編號 */
rtbfseq       number(10,0)      ,/* 項次 */
rtbfseq1       number(10,0)      ,/* 序號 */
rtbf001       varchar2(40)      ,/* 商品主條碼 */
rtbf002       varchar2(40)      ,/* 商品編號 */
rtbf003       varchar2(10)      ,/* 銷售單位 */
rtbf004       varchar2(10)      ,/* 庫區編號 */
rtbf005       varchar2(30)      ,/* 批次編號 */
rtbf006       varchar2(10)      ,/* 供應商編號 */
rtbf007       number(20,6)      ,/* 進價 */
rtbf008       number(20,6)      ,/* 數量 */
rtbf009       number(20,6)      ,/* 轉類發生金額 */
rtbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtbfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtbf_t add constraint rtbf_pk primary key (rtbfent,rtbfdocno,rtbfseq,rtbfseq1) enable validate;

create unique index rtbf_pk on rtbf_t (rtbfent,rtbfdocno,rtbfseq,rtbfseq1);

grant select on rtbf_t to tiptop;
grant update on rtbf_t to tiptop;
grant delete on rtbf_t to tiptop;
grant insert on rtbf_t to tiptop;

exit;
