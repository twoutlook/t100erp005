/* 
================================================================================
檔案代號:rtjp_t
檔案名稱:銷售整合券銷售明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtjp_t
(
rtjpent       number(5)      ,/* 企業代碼 */
rtjpsite       varchar2(10)      ,/* 營運據點 */
rtjpdocno       varchar2(20)      ,/* 單據編號 */
rtjpseq       number(10,0)      ,/* 項次 */
rtjpseq1       number(10,0)      ,/* 序 */
rtjp001       varchar2(30)      ,/* 開始券號 */
rtjp002       varchar2(30)      ,/* 結束券號 */
rtjp003       varchar2(10)      ,/* 券種 */
rtjp004       varchar2(10)      ,/* 券面額編號 */
rtjp005       number(20,6)      ,/* 券張數 */
rtjp006       number(20,6)      ,/* 券總金額 */
rtjp007       varchar2(10)      ,/* 庫區 */
rtjp008       varchar2(30)      ,/* 指定對應會員卡號 */
rtjp009       number(20,6)      ,/* 售券折扣 */
rtjpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtjpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtjpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtjpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtjpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtjpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtjpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtjpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtjpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtjpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtjpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtjpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtjpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtjpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtjpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtjpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtjpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtjpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtjpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtjpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtjpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtjpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtjpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtjpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtjpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtjpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtjpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtjpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtjpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtjpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtjp_t add constraint rtjp_pk primary key (rtjpent,rtjpdocno,rtjpseq,rtjpseq1) enable validate;

create unique index rtjp_pk on rtjp_t (rtjpent,rtjpdocno,rtjpseq,rtjpseq1);

grant select on rtjp_t to tiptop;
grant update on rtjp_t to tiptop;
grant delete on rtjp_t to tiptop;
grant insert on rtjp_t to tiptop;

exit;
